import UIKit

final class FirstFormViewController: UIViewController {
    
    // MARK: - Dependencies:
    weak var coordinator: CoordinatorProtocol?
    
    private let viewModel: FirstFormViewModelProtocol?
    private let collectionProvider: FirstFormCollectionViewProvider
    
    // MARK: - Constants and Variables:
    private enum FirstFormUIConstants {
        static let collectionHeight: CGFloat = 450
        static let enterNameRadius: CGFloat = 20
        static let enterNameWarningInset: CGFloat = 10
    }
    
    private var collectionHeightAnchor: NSLayoutConstraint?
    
    // MARK: - UI:
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .bodyMediumRegularFont
        label.textColor = .gray
        label.text = L10n.FirstForm.title
        
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .headerSmallBoldFont
        label.textColor = .blackDay
        label.text = L10n.FirstForm.name
        
        return label
    }()
    
    private lazy var enterNameTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.bounds.height))
        textField.leftViewMode = .always
        textField.clearButtonMode = .whileEditing
        textField.layer.cornerRadius = FirstFormUIConstants.enterNameRadius
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.placeholder = L10n.FirstForm.namePlaceholder
        textField.backgroundColor = .whiteDay
        textField.textColor = .blackDay
        textField.font = .captionMediumRegularFont
        
        return textField
    }()
    
    private lazy var firstFormCollectionView: BaseCollectionView = {
        let collection = BaseCollectionView()
        collection.register(BaseCollectionViewCell.self,
                            forCellWithReuseIdentifier: Resources.Identifiers.formInterestCollectionVewCell)
        collection.register(BaseCollectionViewEnterCell.self,
                            forCellWithReuseIdentifier: Resources.Identifiers.formEnterInterestCollectionVewCell)
        collection.register(BaseCollectionViewReusableView.self,
                            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                            withReuseIdentifier: Resources.Identifiers.collectionReusableView)
        collection.isScrollEnabled = false
        collection.backgroundColor = .whiteDay
        
        return collection
    }()
    
    private lazy var customNavigationBar = BaseNavigationBar(title: L10n.FirstForm.turn, isBackButton: false, coordinator: coordinator)
    private lazy var continueButton = BaseCustomButton(buttonState: .normal, buttonText: L10n.FirstForm.continueButton)
    private lazy var cellWarningLabel = BaseWarningLabel()
    private lazy var enterNameWarningLabel = UILabel()
    private lazy var screenScrollView = UIScrollView()
    
    // MARK: - Lifecycle:
    init(coordinator: CoordinatorProtocol?, viewModel: FirstFormViewModelProtocol, collectionProvider: FirstFormCollectionViewProvider) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        self.collectionProvider = collectionProvider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupTargets()
        setupCollectionProvider()
        setupObservers()
        
        continueButton.block()
        bind()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupContinueButtonConstraints()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Override Methods:
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: - Private Methods:
    private func bind() {
        viewModel?.interestsObservable.bind { [weak self] _ in
            guard let self else { return }
            self.resumeOnMainThread(self.updateCollection, with: ())
        }
        
        viewModel?.userNameObservable.bind { [weak self] newValue in
            guard let self else { return }
            if newValue == nil {
                self.resumeOnMainThread(self.continueButton.block, with: ())
            } else {
                self.resumeOnMainThread(self.continueButton.unblock, with: ())
            }
        }
        
        viewModel?.selectedInterestsObservable.bind { [weak self] interests in
            guard let self else { return }
            self.resumeOnMainThread(self.controlCellsAvailability, with: interests.count)
        }
    }
    
    private func updateCollection() {
        let indexPath = IndexPath(row: firstFormCollectionView.visibleCells.count - 1, section: 0)
        
        firstFormCollectionView.performBatchUpdates {
            firstFormCollectionView.insertItems(at: [indexPath])
            increaseHeightAnchor(from: view.frame.height, constraints: collectionHeightAnchor ?? NSLayoutConstraint())
        }
        
        firstFormCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .bottom)
    }
    
    private func controlCellsAvailability(with number: Int) {
        let maxCountOfSelectedTargets = 3
        
        if number == maxCountOfSelectedTargets {
            changeCellAvailability(isAvailable: false, with: number)
        } else {
            changeCellAvailability(isAvailable: true, with: number)
        }
    }
    
    private func changeCellAvailability(isAvailable: Bool, with number: Int) {
        let cells = firstFormCollectionView.visibleCells
        
        if isAvailable {
            cells.forEach { cell in
                if let cell = cell as? BaseCollectionViewEnterCell {
                    cell.controlStateButton(isBlock: false)
                }
                
                cell.isUserInteractionEnabled = true
            }
            
            controlStateWarningLabel(label: cellWarningLabel, isShow: false)
        } else {
            cells.forEach { cell in
                if let cell = cell as? BaseCollectionViewEnterCell {
                    cell.controlStateButton(isBlock: true)
                }
                
                cell.isUserInteractionEnabled = cell.isSelected == true ? true : false
            }
            
            controlStateWarningLabel(label: cellWarningLabel,
                                     isShow: true,
                                     from: firstFormCollectionView,
                                     with: L10n.Warning.optionLimits)
        }
    }
    
    private func showEnterNameWarningLabel() {
        enterNameWarningLabel.font = .captionSmallRegularFont
        enterNameWarningLabel.textColor = .universalRed
        enterNameWarningLabel.textAlignment = .left
        enterNameWarningLabel.text = L10n.Warning.wrongWord
        
        view.setupView(enterNameWarningLabel)
        
        NSLayoutConstraint.activate([
            enterNameWarningLabel.topAnchor.constraint(equalTo: enterNameTextField.bottomAnchor, constant: FirstFormUIConstants.enterNameWarningInset),
            enterNameWarningLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.sideInset),
            enterNameWarningLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: UIConstants.sideInset)
        ])
    }
    
    private func setupCollectionProvider() {
        firstFormCollectionView.dataSource = collectionProvider
        firstFormCollectionView.delegate = collectionProvider

    }
    
    // MARK: - Objc Methods:
    @objc private func goToSecondFormVC() {
        AnalyticsService.instance.trackAmplitudeEvent(with: "goToSecondFormScreen", params: nil)
        coordinator?.goToSecondFormViewController()
        viewModel?.sentInterests()
    }
}

// MARK: - BaseCollectionViewCellDelegate:
extension FirstFormViewController: BaseCollectionViewCellDelegate {
    func changeTargetState(isAdded: Bool, cell: BaseCollectionViewCell) {
        guard let model = cell.cellModel else { return }
        
        viewModel?.controlInterestState(isAdd: isAdded, interest: GreetingTarget(name: model.name,
                                                                                 image: model.image))
    }
}

// MARK: - BaseCollectionViewEnterCellDelegate:
extension FirstFormViewController: BaseCollectionViewEnterCellDelegate {
    func addNewTarget(name: String) {
        viewModel?.addNewOwnInterest(name: name)
    }
    
    func changeStateCellWarningLabel(isShow: Bool, isWrongText: Bool) {
        if isShow {
            controlStateWarningLabel(label: cellWarningLabel,
                                     isShow: true,
                                     from: firstFormCollectionView,
                                     with: isWrongText ? L10n.Warning.wrongWord : L10n.Warning.characterLimits)
        } else {
            controlStateWarningLabel(label: cellWarningLabel,
                                     isShow: false)
        }
    }
}

// MARK: - UITextFieldDelegate:
extension FirstFormViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let text = textField.text
        
        if ProhibitedDictionaryService().isWordProhibited(with: text ?? "") {
            showEnterNameWarningLabel()
        } else {
            enterNameWarningLabel.removeFromSuperview()
            viewModel?.setupUsername(text)
        }
    }
}

// MARK: - Setup Views:
private extension FirstFormViewController {
    func setupViews() {
        view.backgroundColor = .whiteDay
        
        customNavigationBar.setupNavigationBar(with: view, controller: self)
        
        [screenScrollView, continueButton].forEach(view.setupView)
        [titleLabel, nameLabel, enterNameTextField, firstFormCollectionView].forEach(screenScrollView.setupView)
    }
    
    func setupConstraints() {
        setupScreenScrollViewConstraints()
        setupTitleLabelConstraints()
        setupNameLabelConstraints()
        setupEnterNameLabelConstraints()
        setupFirstCollectionViewConstraints()
        
        [screenScrollView, firstFormCollectionView].forEach {
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        }
        
        [titleLabel, nameLabel, enterNameTextField, continueButton].forEach {
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                        constant: UIConstants.sideInset).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                         constant: -UIConstants.sideInset).isActive = true
        }
    }
    
    func setupScreenScrollViewConstraints() {
        screenScrollView.topAnchor.constraint(equalTo: customNavigationBar.bottomAnchor).isActive = true
        screenScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func setupTitleLabelConstraints() {
        titleLabel.topAnchor.constraint(equalTo: screenScrollView.topAnchor,
                                        constant: UIConstants.sideInset).isActive = true
    }
    
    func setupNameLabelConstraints() {
        nameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                       constant: UIConstants.blocksInset).isActive = true
    }
    
    func setupEnterNameLabelConstraints() {
        enterNameTextField.heightAnchor.constraint(equalToConstant: UIConstants.blocksInset).isActive = true
        enterNameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,
                                                constant: UIConstants.elementsInset).isActive = true
    }
    
    func setupFirstCollectionViewConstraints() {
        let bottomAnchor = UIConstants.sideInset + UIConstants.buttonHeight + UIConstants.sideInset
        
        collectionHeightAnchor = firstFormCollectionView.heightAnchor.constraint(equalToConstant: FirstFormUIConstants.collectionHeight)
        collectionHeightAnchor?.isActive = true
        
        firstFormCollectionView.topAnchor.constraint(equalTo: enterNameTextField.bottomAnchor,
                                                     constant: UIConstants.sideInset).isActive = true
        firstFormCollectionView.bottomAnchor.constraint(equalTo: screenScrollView.bottomAnchor,
                                                        constant: -bottomAnchor).isActive = true
    }
    
    func setupContinueButtonConstraints() {
        let numberOfItems = firstFormCollectionView.numberOfItems(inSection: 0)
        let indexPath = IndexPath(row: numberOfItems - 1, section: 0)
        
        guard let lastCell = firstFormCollectionView.cellForItem(at: indexPath) else { return }
        
        let buttonTopAnchor = continueButton.topAnchor.constraint(
            greaterThanOrEqualTo: lastCell.bottomAnchor,
            constant: UIConstants.blocksInset)
        let buttonBottomAnchor = continueButton.bottomAnchor.constraint(
            equalTo: screenScrollView.bottomAnchor,
            constant: -UIConstants.blocksInset)
        
        buttonTopAnchor.priority = .defaultHigh
        buttonBottomAnchor.priority = .defaultLow
        
        buttonTopAnchor.isActive = true
        buttonBottomAnchor.isActive = true
    }
    
    func setupTargets() {
        continueButton.addTarget(self, action: #selector(goToSecondFormVC), for: .touchUpInside)
    }
}
