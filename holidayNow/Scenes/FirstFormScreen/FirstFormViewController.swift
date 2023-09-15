import UIKit

final class FirstFormViewController: UIViewController {
    
    // MARK: - Dependencies:
    weak var coordinator: CoordinatorProtocol?
    
    private var viewModel: FirstFormViewModelProtocol?
    
    // MARK: - Constants and Variables:
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
        textField.layer.cornerRadius = 20
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
        collection.dataSource = self
        collection.delegate = self
        collection.isScrollEnabled = false
        collection.backgroundColor = .whiteDay
        
        return collection
    }()
    
    private lazy var customNavigationBar = BaseNavigationBar(title: L10n.FirstForm.turn, isBackButton: false, coordinator: coordinator)
    private lazy var continueButton = BaseCustomButton(buttonState: .normal, buttonText: L10n.FirstForm.continueButton)
    private lazy var warningLabel = BaseWarningLabel()
    private lazy var screenScrollView = UIScrollView()
    
    // MARK: - Lifecycle:
    init(coordinator: CoordinatorProtocol?, viewModel: FirstFormViewModelProtocol) {
        self.coordinator = coordinator
        self.viewModel = viewModel
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
        let cells = firstFormCollectionView.visibleCells
        
        if number == 3 {
            cells.forEach { cell in
                if let cell = cell as? BaseCollectionViewEnterCell {
                    cell.controlStateButton(isBlock: true)
                }
                
                cell.isUserInteractionEnabled = cell.isSelected == true ? true : false
            }
            
            controlStateWarningLabel(label: warningLabel,
                                     isShow: true,
                                     from: firstFormCollectionView,
                                     with: L10n.FirstForm.warningOptionLimits)
        } else {
            cells.forEach { cell in
                if let cell = cell as? BaseCollectionViewEnterCell {
                    cell.controlStateButton(isBlock: false)
                }
                
                cell.isUserInteractionEnabled = true
            }
            
            controlStateWarningLabel(label: warningLabel, isShow: false)
        }
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
    
    func changeStateWarningLabel(isShow: Bool) {
        if isShow {
            controlStateWarningLabel(label: warningLabel,
                                     isShow: true,
                                     from: firstFormCollectionView,
                                     with: L10n.FirstForm.warningCharacterLimits)
        } else {
            controlStateWarningLabel(label: warningLabel,
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
        
        viewModel?.setupUsername(text)
    }
}

// MARK: - UICollectionViewDataSource
extension FirstFormViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let interests = viewModel?.interestsObservable.wrappedValue.interests else { return 0 }
        
        return interests.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let interests = viewModel?.interestsObservable.wrappedValue.interests else { return UICollectionViewCell() }
        
        if indexPath.row == interests.count {
            // Enter cell:
            let cell: BaseCollectionViewEnterCell = collectionView.dequeueReusableCell(
                indexPath: indexPath,
                with: Resources.Identifiers.formEnterInterestCollectionVewCell)
            
            cell.delegate = self
            cell.setupCellWidht(value: view.frame.width)
            
            return cell
        } else {
            // Default cell:
            let cell: BaseCollectionViewCell = collectionView.dequeueReusableCell(
                indexPath: indexPath,
                with: Resources.Identifiers.formInterestCollectionVewCell)
            
            let model = interests[indexPath.row]
            
            cell.delegate = self
            cell.setupInterestModel(model: CellModel(name: model.name, image: model.image))
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let text = viewModel?.interestsObservable.wrappedValue.name
        var id: String
        
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            id = Resources.Identifiers.collectionReusableView
        default:
            id = ""
        }
        
        guard let headerView = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: id,
            for: indexPath) as? BaseCollectionViewReusableView else { return UICollectionReusableView() }
        
        headerView.setupLabelName(with: text ?? "")
        
        return headerView
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FirstFormViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let indexPath = IndexPath(row: 0, section: section)
        let headerView = self.collectionView(collectionView,
                                             viewForSupplementaryElementOfKind: UICollectionView.elementKindSectionHeader,
                                             at: indexPath)

        return headerView.systemLayoutSizeFitting(CGSize(width: collectionView.frame.width,
                                                         height: UIView.layoutFittingExpandedSize.height),
                                                  withHorizontalFittingPriority: .required,
                                                  verticalFittingPriority: .fittingSizeLevel)
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
        collectionHeightAnchor = firstFormCollectionView.heightAnchor.constraint(equalToConstant: 450)
        collectionHeightAnchor?.isActive = true
                
        NSLayoutConstraint.activate([
            screenScrollView.topAnchor.constraint(equalTo: customNavigationBar.bottomAnchor),
            screenScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            screenScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            screenScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: screenScrollView.topAnchor, constant: 20),
            
            nameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            
            enterNameTextField.heightAnchor.constraint(equalToConstant: 40),
            enterNameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 24),
        
            firstFormCollectionView.topAnchor.constraint(equalTo: enterNameTextField.bottomAnchor, constant: 20),
            firstFormCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            firstFormCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            firstFormCollectionView.bottomAnchor.constraint(equalTo: screenScrollView.bottomAnchor, constant: -100)
        ])
        
        [titleLabel, nameLabel, enterNameTextField, continueButton].forEach {
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        }
    }
    
    func setupContinueButtonConstraints() {
        let numberOfItems = firstFormCollectionView.numberOfItems(inSection: 0)
        let indexPath = IndexPath(row: numberOfItems - 1, section: 0)
        
        guard let lastCell = firstFormCollectionView.cellForItem(at: indexPath) else { return }

        let buttonTopAnchor = continueButton.topAnchor.constraint(
            greaterThanOrEqualTo: lastCell.bottomAnchor,
            constant: 40)
        let buttonBottomAnchor = continueButton.bottomAnchor.constraint(
            equalTo: screenScrollView.bottomAnchor,
            constant: -40)
        
        buttonTopAnchor.priority = .defaultHigh
        buttonBottomAnchor.priority = .defaultLow
        
        buttonTopAnchor.isActive = true
        buttonBottomAnchor.isActive = true
    }
    
    func setupTargets() {                                             
        continueButton.addTarget(self, action: #selector(goToSecondFormVC), for: .touchUpInside)
    }
}
