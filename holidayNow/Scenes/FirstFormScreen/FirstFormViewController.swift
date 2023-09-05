import UIKit

final class FirstFormViewController: UIViewController {
    
    // MARK: - Dependencies:
    weak var coordinator: CoordinatorProtocol?
    
    private var viewModel: FirstFormViewModelProtocol?
    
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
        
        return textField
    }()
    
    private lazy var firstFormCollectionView: BaseCollectionView = {
        let collection = BaseCollectionView()
        collection.dataSource = self
        collection.delegate = self
        collection.register(BaseCollectionViewCell.self, forCellWithReuseIdentifier: Resources.Identifiers.firstFormInterestsCell)
        
        return collection
    }()
    
    private lazy var continueButton = BaseCustomButton(buttonState: .normal, ButtonText: L10n.Congratulation.continue)
    
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
        
        continueButton.block()
        bind()
    }
    
    // MARK: - Override Methods:
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // MARK: - Private Methods:
    private func bind() {
        viewModel?.interestsObservable.bind { [weak self] _ in
            guard let self else { return }
        }
        
        viewModel?.userNameObservable.bind { [weak self] newValue in
            guard let self else { return }
            DispatchQueue.main.async {
                newValue == nil ? self.continueButton.block() : self.continueButton.unblock()
            }
        }
    }
}

// MARK: - BaseCollectionViewCellDelegate
extension FirstFormViewController: BaseCollectionViewCellDelegate {
    func changeInterestState(isAdded: Bool, model: GreetingTarget) {
        viewModel?.controlInterestState(isAdd: isAdded, interest: model)
    }
}

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
        let interests = viewModel?.interestsObservable.wrappedValue[0].interests
        return interests?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Resources.Identifiers.firstFormInterestsCell, for: indexPath) as? BaseCollectionViewCell,
              let interests = viewModel?.interestsObservable.wrappedValue[0].interests else { return UICollectionViewCell() }
        
        let model = interests[indexPath.row]
        
        cell.delegate = self
        cell.setupInterestModel(model: model)
        
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
