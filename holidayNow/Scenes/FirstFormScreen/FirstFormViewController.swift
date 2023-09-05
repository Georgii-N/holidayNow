import UIKit

final class FirstFormViewController: UIViewController {
    
    // MARK: - UI:
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .captionMediumRegularFont
        label.textColor = .gray
        label.text = L10n.FirstForm.title
        
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .captionLargeBoldFont
        label.textColor = .blackDay
        label.text = L10n.FirstForm.name
        
        return label
    }()
    
    private lazy var enterNameTextField: UITextField = {
        let textField = UITextField()
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.bounds.height))
        textField.leftViewMode = .always
        textField.layer.cornerRadius = 20
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.placeholder = L10n.FirstForm.namePlaceholder
        textField.backgroundColor = .whiteDay
        textField.textColor = .blackDay
        
        return textField
    }()
    
    private lazy var firstFormCollectionView: BaseCollectionView = {
        let collection = BaseCollectionView()
        collection.register(BaseCollectionViewCell.self, forCellWithReuseIdentifier: Resources.Identifiers.firstFormInterestsCell)
        collection.dataSource = self
        collection.delegate = self
        
        return collection
    }()
    
    private lazy var continueButton = BaseCustomButton(buttonState: .normal, ButtonText: L10n.Congratulation.continue)
    
    // MARK: - Lifecycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        
        continueButton.block()
    }
}

// MARK: - UICollectionViewDataSource
extension FirstFormViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Resources.Identifiers.firstFormInterestsCell, for: indexPath) as? BaseCollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FirstFormViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 35)
    }
}

// MARK: - Setup Views:
private extension FirstFormViewController {
    func setupViews() {
        view.backgroundColor = .whiteDay
        
        [titleLabel, nameLabel, enterNameTextField, firstFormCollectionView, continueButton].forEach(view.setupView)
    }
    
    func setupConstraints() {        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            nameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            
            enterNameTextField.heightAnchor.constraint(equalToConstant: 40),
            enterNameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 30),
            
            firstFormCollectionView.topAnchor.constraint(equalTo: enterNameTextField.bottomAnchor, constant: 30),
            firstFormCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            firstFormCollectionView.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -100),
            firstFormCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            continueButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ])
        
        [titleLabel, nameLabel, enterNameTextField, continueButton].forEach {
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        }
    }
}
