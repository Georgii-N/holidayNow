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
        setupContinueButtonConstraints()
        presetGreetingsInfo()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.sentGreetingsInfo()
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
            self.resumeOnMainThread(self.checkSelectedHoliday, with: ())
        }
    }
    
    private func updateCollection() {
        let countOfExistedHolidays = viewModel.holidaysObserver.wrappedValue.holidays.count
        let visibleHolidays = secondFormCollectionView.numberOfItems(inSection: 0)
        let isCellAdded = visibleHolidays == countOfExistedHolidays
        let indexToRemoveCell = viewModel.indexToRemoveCell ?? 0
        let indexPath = IndexPath(row: isCellAdded ? visibleHolidays - 1 : indexToRemoveCell, section: 0)

        secondFormCollectionView.performBatchUpdates {
            if isCellAdded {
                secondFormCollectionView.insertItems(at: [indexPath])
                controlCellsAnimations(isStart: false)
                changeCollectionViewHeightAnchor(isIncrease: true, from: view.frame.height, constraints: collectionHeightAnchor ?? NSLayoutConstraint())
            } else {
                secondFormCollectionView.deleteItems(at: [indexPath])
                let enterCellIndexPath = IndexPath(row: secondFormCollectionView.numberOfItems(inSection: 0) - 1, section: 0)
                guard let cell = secondFormCollectionView.cellForItem(at: enterCellIndexPath) as? BaseCollectionViewEnterCell else { return }
                cell.decrementAddedInterestsCounter()
                changeCollectionViewHeightAnchor(isIncrease: false, from: view.frame.height, constraints: collectionHeightAnchor ?? NSLayoutConstraint())
            }
        }
        
        if isCellAdded {
            secondFormCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .bottom)
        }
    }
    
    private func controlCellsAnimations(isStart: Bool) {
        let indexPaths = secondFormCollectionView.indexPathsForVisibleItems
        
        indexPaths.forEach { indexPath in
            guard let cell = secondFormCollectionView.cellForItem(at: indexPath) as? BaseCollectionViewCell,
                  let cellModel = cell.cellModel else { return }
            
            if isStart == true && cellModel.isDefault == false {
                cell.startEditingButton()
            } else {
                cell.stopAnimation()
            }
        }
    }
    
    private func checkSelectedHoliday() {
        viewModel.selectedHolidayObservable.wrappedValue != nil ? continueButton.unblock() : continueButton.block()
    }
    
    private func setupCollectionProvider() {
        secondFormCollectionView.dataSource = collectionProvider
        secondFormCollectionView.delegate = collectionProvider
    }
    
    private func presetGreetingsInfo() {
        let cells = secondFormCollectionView.visibleCells
        let selectedHoliday = viewModel.selectedHolidayObservable.wrappedValue ?? ""
        let selectedIntonation = viewModel.selectedIntonation ?? ""
        
        if selectedHoliday != "" || selectedIntonation != "" {
            cells.forEach { cell in
                guard let cell = cell as? BaseCollectionViewCell else { return }
                let name = cell.cellModel?.name
                
                if name == selectedHoliday || name == selectedIntonation {
                    guard let indexPath = secondFormCollectionView.indexPath(for: cell) else { return }
                    secondFormCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .top)
                }
            }
        }
    }
    
    // MARK: - Objc Methods:
    @objc private func switchToCongratulationType() {
        coordinator?.goToCongratulationTypeViewController()
        AnalyticsService.instance.trackAmplitudeEvent(name: .goToCongratulationType, params: nil)
    }
}

// MARK: - BaseCollectionViewCellDelegate:
extension SecondFormViewController: BaseCollectionViewCellDelegate {
    func changeTargetState(isAdded: Bool, cell: BaseCollectionViewCell) {
        guard let indexPath = secondFormCollectionView.indexPath(for: cell),
              let model = cell.cellModel else { return }
        
        switch indexPath.section {
        case 0:
            if isAdded {
                viewModel.setupHoliday(name: model.name)
            } else if secondFormCollectionView.indexPathsForSelectedItems?.count == 0 {
                viewModel.setupHoliday(name: nil)
            }
        case 1:
            if isAdded {
                viewModel.setupIntonation(name: model.name)
            } else if secondFormCollectionView.indexPathsForSelectedItems?.count == 0 {
                viewModel.setupIntonation(name: nil)
            }
        default:
            break
        }
    }
    
    func startEditingNonDefaultCells() {
        controlCellsAnimations(isStart: true)
    }
    
    func remove(cell: BaseCollectionViewCell) {
        guard let indexPath = secondFormCollectionView.indexPath(for: cell) else { return }
        viewModel.removeOwnInterest(from: indexPath.row)
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
