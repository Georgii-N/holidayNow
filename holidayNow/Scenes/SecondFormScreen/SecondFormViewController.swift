import UIKit

final class SecondFormViewController: UIViewController {
    
    // MARK: - Dependencies:
    weak var coordinator: CoordinatorProtocol?
    
    private let viewModel: SecondFormViewModelProtocol
    private let collectionProvider: SecondFormCollectionProvider
    
    // MARK: - Constants and Variables:
    private enum SecondFormUIConstants {
        static let collectionHeight: CGFloat = 570
    }
    
    private var collectionHeightAnchor: NSLayoutConstraint?
    
    // MARK: - UI:
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .bodyMediumRegularFont
        label.textColor = .gray
        label.text = L10n.SecondForm.title
        
        return label
    }()
    
    private(set) lazy var secondFormCollectionView: BaseCollectionView = {
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
    
    private lazy var customNavigationBar = BaseNavigationBar(title: L10n.SecondForm.turn, isBackButton: true, coordinator: coordinator)
    private lazy var continueButton = BaseCustomButton(buttonState: .normal, buttonText: L10n.SecondForm.continueButton)
    private lazy var warningLabel = BaseWarningLabel()
    private lazy var screenScrollView = UIScrollView()
    
    // MARK: - Lifecycle:
    init(coordinator: CoordinatorProtocol?, viewModel: SecondFormViewModelProtocol, collectionProvider: SecondFormCollectionProvider) {
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
        
        bind()
        continueButton.block()
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
        viewModel.holidaysObserver.bind { [weak self] _ in
            guard let self else { return }
            self.resumeOnMainThread(self.updateCollection, with: ())
        }
        
        viewModel.selectedHolidayObservable.bind { [weak self] _ in
            guard let self else { return }
            if self.secondFormCollectionView.indexPathsForSelectedItems?.count == 0 {
                self.resumeOnMainThread(self.continueButton.block, with: ())
            } else {
                self.resumeOnMainThread(self.checkSelectedCell, with: ())
            }
        }
    }
    
    private func updateCollection() {
        let indexPath = IndexPath(row: viewModel.holidaysObserver.wrappedValue.holidays.count - 1, section: 0)
        
        secondFormCollectionView.performBatchUpdates {
            secondFormCollectionView.insertItems(at: [indexPath])
            increaseHeightAnchor(from: view.frame.height, constraints: collectionHeightAnchor ?? NSLayoutConstraint())
        }
        
        secondFormCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .top)
    }
    
    private func checkSelectedCell() {
        guard let selectedIndexes = secondFormCollectionView.indexPathsForSelectedItems else { return }
        if selectedIndexes.contains(where: { $0.section == 0 }) {
            continueButton.unblock()
        } else {
            continueButton.block()
        }
    }
    
    private func setupCollectionProvider() {
        secondFormCollectionView.dataSource = collectionProvider
        secondFormCollectionView.delegate = collectionProvider
    }
    
    // MARK: - Objc Methods:
    @objc private func switchToCongratulationType() {
        viewModel.sentGreetingsInfo()
        coordinator?.goToCongratulationTypeViewController()
        AnalyticsService.instance.trackAmplitudeEvent(with: "goToCongratulationType", params: nil)
    }
}

// MARK: - BaseCollectionViewCellDelegate:
extension SecondFormViewController: BaseCollectionViewCellDelegate {
    func changeTargetState(isAdded: Bool, cell: BaseCollectionViewCell) {
        guard let indexPath = secondFormCollectionView.indexPath(for: cell),
              let model = cell.cellModel else { return }
        
        switch indexPath.section {
        case 0:
            isAdded ? viewModel.setupHoliday(name: model.name) : viewModel.setupHoliday(name: nil)
        case 1:
            isAdded ? viewModel.setupIntonation(name: model.name) : viewModel.setupIntonation(name: nil)
        default:
            break
        }
    }
}

// MARK: - BaseCollectionViewEnterCellDelegate:
extension SecondFormViewController: BaseCollectionViewEnterCellDelegate {
    func addNewTarget(name: String) {
        if let indexPath = secondFormCollectionView.indexPathsForSelectedItems?.first(where: { $0.section == 0 }) {
            secondFormCollectionView.deselectItem(at: indexPath, animated: true)
        }
        
        viewModel.addNewHoliday(with: name)
    }
    
    func changeStateCellWarningLabel(isShow: Bool, isWrongText: Bool) {
        if isShow {
            controlStateWarningLabel(label: warningLabel,
                                     isShow: true,
                                     from: secondFormCollectionView,
                                     with: isWrongText ? L10n.Warning.wrongWord : L10n.Warning.characterLimits)
        } else {
            controlStateWarningLabel(label: warningLabel,
                                     isShow: false)
        }
    }
}

// MARK: - Setup Views:
private extension SecondFormViewController {
    func setupViews() {
        view.backgroundColor = .whiteDay
        
        customNavigationBar.setupNavigationBar(with: view, controller: self)
        
        view.setupView(screenScrollView)
        [titleLabel, secondFormCollectionView, continueButton].forEach(screenScrollView.setupView)
    }
    
    func setupConstraints() {
        setupScreenScrollViewConstraints()
        setupTitleLabelConstraints()
        setupSecondFormCollectionViewConstraints()
        
        [screenScrollView, secondFormCollectionView].forEach {
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        }
        
        [titleLabel, continueButton].forEach {
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
    
    func setupSecondFormCollectionViewConstraints() {
        let bottomAnchor = UIConstants.sideInset + UIConstants.buttonHeight + UIConstants.sideInset
        
        collectionHeightAnchor = secondFormCollectionView.heightAnchor.constraint(equalToConstant: SecondFormUIConstants.collectionHeight)
        collectionHeightAnchor?.isActive = true
        
        secondFormCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                                      constant: UIConstants.sideInset).isActive = true
        secondFormCollectionView.bottomAnchor.constraint(equalTo: screenScrollView.bottomAnchor,
                                                         constant: -bottomAnchor).isActive = true
    }
    
    func setupContinueButtonConstraints() {
        let numberOfItems = secondFormCollectionView.numberOfItems(inSection: 1)
        let indexPath = IndexPath(row: numberOfItems - 1, section: 1)
        
        guard let lastCell = secondFormCollectionView.cellForItem(at: indexPath) else { return }
        
        let buttonTopAnchor = continueButton.topAnchor.constraint(
            greaterThanOrEqualTo: lastCell.bottomAnchor,
            constant: UIConstants.blocksInset)
        let buttonBottomAnchor = continueButton.bottomAnchor.constraint(
            equalTo: view.bottomAnchor,
            constant: -UIConstants.blocksInset)
        
        buttonTopAnchor.priority = .defaultHigh
        buttonBottomAnchor.priority = .defaultLow
        
        buttonTopAnchor.isActive = true
        buttonBottomAnchor.isActive = true
    }
    
    func setupTargets() {
        continueButton.addTarget(self, action: #selector(switchToCongratulationType), for: .touchUpInside)
    }
}
