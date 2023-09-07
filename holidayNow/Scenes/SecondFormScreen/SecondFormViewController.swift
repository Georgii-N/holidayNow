import UIKit

final class SecondFormViewController: UIViewController {
    
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
        collection.isScrollEnabled = false
        collection.dataSource = self
        collection.delegate = self
        collection.register(BaseCollectionViewCell.self, forCellWithReuseIdentifier: Resources.Identifiers.secondFormInterestsCell)
        collection.register(BaseCollectionViewEnterCell.self, forCellWithReuseIdentifier: Resources.Identifiers.secondFormEnterInterestCell)
        collection.backgroundColor = .whiteDay
        
        return collection
    }()
    
    private lazy var startMagicButton = BaseCustomButton(buttonState: .normal, buttonText: L10n.SecondForm.startMagic)
    
    // MARK: - Lifecycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupTargets()
    }
}

// MARK: - UICollectionViewDataSource:
extension SecondFormViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        UICollectionViewCell()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout:
extension SecondFormViewController: UICollectionViewDelegateFlowLayout {
    
}

// MARK: - Setup Views:
private extension SecondFormViewController {
    func setupViews() {
        [titleLabel, secondFormCollectionView, startMagicButton].forEach(view.setupView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
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
        
    }
}
