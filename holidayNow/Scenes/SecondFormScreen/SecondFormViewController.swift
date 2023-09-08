import UIKit

final class SecondFormViewController: UIViewController {
    
    // MARK: - Dependencies:
    weak var coordinator: CoordinatorProtocol?
    
    private var viewModel: SecondFormViewModelProtocol
    
    // MARK: - UI:
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .captionMediumRegularFont
        label.textColor = .gray
        label.text = L10n.SecondForm.title
        
        return label
    }()
    
    private lazy var secondFormCollectionView: BaseCollectionView = {
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
        
        collection.backgroundColor = .whiteDay
        
        return collection
    }()
    
    private lazy var customNavigationBar = BaseNavigationBar(title: L10n.SecondForm.turn, isBackButton: true, coordinator: coordinator)
    private lazy var startMagicButton = BaseCustomButton(buttonState: .normal, buttonText: L10n.SecondForm.startMagic)
    
    // MARK: - Lifecycle:
    init(coordinator: CoordinatorProtocol?, viewModel: SecondFormViewModelProtocol) {
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
        
        bind()
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
    }
    
    private func updateCollection() {
        let indexPath = IndexPath(row: viewModel.holidaysObserver.wrappedValue.holidays.count - 1, section: 0)
        
        secondFormCollectionView.performBatchUpdates {
            secondFormCollectionView.insertItems(at: [indexPath])
        }
        
        secondFormCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .top)
    }
    
    private func getParticularCell(isDefault: Bool, indexPath: IndexPath, isHoliday: Bool) -> UICollectionViewCell {
        if isDefault {
            let defaultCell: BaseCollectionViewCell = secondFormCollectionView.dequeueReusableCell(
                indexPath: indexPath,
                with: Resources.Identifiers.formInterestCollectionVewCell)
            defaultCell.delegate = self

            
            if isHoliday {
                let model = viewModel.holidaysObserver.wrappedValue.holidays[indexPath.row]
                defaultCell.setupInterestModel(model: CellModel(name: model.name, image: model.image))
                
                return defaultCell
            } else {
                let model = viewModel.intonations.intonations[indexPath.row]
                defaultCell.setupInterestModel(model: CellModel(name: model.name, image: model.image))
                
                return defaultCell
            }
        } else {
            let defaultEnterCell: BaseCollectionViewEnterCell = secondFormCollectionView.dequeueReusableCell(
                indexPath: indexPath,
                with: Resources.Identifiers.formEnterInterestCollectionVewCell)
            
            defaultEnterCell.delegate = self
            defaultEnterCell.setupCellWidht(value: view.frame.width)
            
            return defaultEnterCell
        }
    }
    
    // MARK: - Objc Methods:
    @objc private func didTapStartMagicButton() {
        viewModel.sentGreetingsInfo()
        coordinator?.goToWaitingViewController()
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
            return 
        }
    }
}

// MARK: - BaseCollectionViewEnterCellDelegate:
extension SecondFormViewController: BaseCollectionViewEnterCellDelegate {
    func addNewTarget(name: String) {
        if let indexPath = secondFormCollectionView.indexPathsForSelectedItems?.first {
            secondFormCollectionView.deselectItem(at: indexPath, animated: true)
        }
        
        viewModel.addNewHoliday(with: name)
    }
}

// MARK: - UICollectionViewDataSource:
extension SecondFormViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return viewModel.holidaysObserver.wrappedValue.holidays.count + 1
        case 1:
            return viewModel.intonations.intonations.count
        default:
            return  0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            if indexPath.row == viewModel.holidaysObserver.wrappedValue.holidays.count  {
                guard let cell = getParticularCell(
                    isDefault: false,
                    indexPath: indexPath,
                    isHoliday: true) as? BaseCollectionViewEnterCell else { return UICollectionViewCell() }
                
                return cell
            } else {
                guard let cell = getParticularCell(
                    isDefault: true,
                    indexPath: indexPath,
                    isHoliday: true) as? BaseCollectionViewCell else { return UICollectionViewCell() }
                
                return cell
            }
        case 1:
            guard let cell = getParticularCell(
                isDefault: true,
                indexPath: indexPath,
                isHoliday: false) as? BaseCollectionViewCell else { return UICollectionViewCell() }
            
            return cell
        default:
            return UICollectionViewCell()
        }
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

// MARK: - UICollectionViewDelegateFlowLayout:
extension SecondFormViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 35)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedIndex = collectionView.indexPathsForSelectedItems else { return }
        
        selectedIndex.forEach { index in
            if index.section == indexPath.section && index.row != indexPath.row {
                collectionView.deselectItem(at: index, animated: true)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var text: String
        var id: String
        
        switch indexPath.section {
        case 0:
            text = viewModel.holidaysObserver.wrappedValue.name
        case 1:
            text = viewModel.intonations.name
        default:
            text = ""
        }
        
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
        
        headerView.setupLabelName(with: text)
        
        return headerView
    }
}

// MARK: - Setup Views:
private extension SecondFormViewController {
    func setupViews() {
        view.backgroundColor = .whiteDay
        customNavigationBar.setupNavigationBar(with: view, controller: self)
        
        [titleLabel, secondFormCollectionView, startMagicButton].forEach(view.setupView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: customNavigationBar.bottomAnchor, constant: 20),
            
            secondFormCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            secondFormCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            secondFormCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            secondFormCollectionView.bottomAnchor.constraint(equalTo: startMagicButton.topAnchor, constant: -30),
            
            startMagicButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ])
        
        [titleLabel, startMagicButton].forEach {
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        }
    }
    
    func setupTargets() {
        startMagicButton.addTarget(self, action: #selector(didTapStartMagicButton), for: .touchUpInside)
    }
}
