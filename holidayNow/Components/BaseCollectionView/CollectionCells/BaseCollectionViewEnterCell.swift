import UIKit

final class BaseCollectionViewEnterCell: UICollectionViewCell {
    
    // MARK: - Dependencies:
    weak var delegate: BaseCollectionViewEnterCellDelegate?
    
    // MARK: - Constant and Variables:
    enum UIConstants: CGFloat {
        case imageSideSize = 20
        case buttonWidht = 70
        case leftInset = 10
        case rightInset = 5
        case viewsInsets = 40
    }
    
    private var interestCounter = 0
    
    // MARK: - UI:
    private lazy var interestImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Resources.Images.FirstForm.addMyOwn
        
        return imageView
    }()
    
    private lazy var enterNameTextField: UITextField = {
        let textField = UITextField()
        textField.delegate = self
        textField.clearButtonMode = .whileEditing
        textField.font = .bodySmallRegularFont
        textField.placeholder = L10n.FirstForm.Interests.addMyOwn
        
        return textField
    }()
    
    private lazy var enterButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 18
        button.backgroundColor = .lightGray
    
        return button
    }()
    
    private var cellWidht: CGFloat? {
        didSet {
            enterNameTextField.widthAnchor.constraint(equalToConstant: cellWidht ?? 0).isActive = true
        }
    }
    
    // MARK: - Lifecycle:
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        setupTargets()
        
        changeButtonState(isEnable: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods:
    func setupCellWidht(value: CGFloat) {
        let totalInsets = UIConstants.leftInset.rawValue + UIConstants.rightInset.rawValue + UIConstants.viewsInsets.rawValue
        let elementWidht = UIConstants.imageSideSize.rawValue + UIConstants.buttonWidht.rawValue
        
        cellWidht = value - totalInsets - elementWidht
    }
    
    // MARK: - Private Methods:
    private func changeButtonState(isEnable: Bool) {
        if isEnable {
            enterButton.backgroundColor = .blackDay
            enterButton.setImage(Resources.Images.CollectionCell.enterButton, for: .normal)
            enterButton.isUserInteractionEnabled = true
        } else {
            let image = Resources.Images.CollectionCell.enterButton.withTintColor(.black, renderingMode: .alwaysOriginal)
            enterButton.backgroundColor = .lightGray
            enterButton.setImage(image, for: .normal)
            enterButton.isUserInteractionEnabled = false
        }
    }
    
    // MARK: - Objc Methods:
    @objc private func addNewInterest() {
        guard let text = enterNameTextField.text else { return }
        delegate?.addNewInterest(name: text)
        interestCounter += 1
        enterNameTextField.text = nil
        
        if interestCounter == 4 {
            changeButtonState(isEnable: false)
            enterNameTextField.isUserInteractionEnabled = false
            enterNameTextField.placeholder = L10n.FirstForm.Interests.noAvailable
        }
    }
}

// MARK: - UITextFieldDelegate
extension BaseCollectionViewEnterCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.length == 1 && !string.isEmpty || range.length == 1 && string.isEmpty && textField.text?.count == 1 {
            changeButtonState(isEnable: false)
        } else {
            changeButtonState(isEnable: true)
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        if textField.hasText {
            changeButtonState(isEnable: false)
        }
        
        return true
    }
}

// MARK: - Setup Views:
private extension BaseCollectionViewEnterCell {
    func setupViews() {
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 18
        
        [interestImageView, enterNameTextField, enterButton].forEach(setupView)
    }
    
    func setupConstraints() {
        let height = bounds.height
        
        NSLayoutConstraint.activate([
            interestImageView.widthAnchor.constraint(equalToConstant: UIConstants.imageSideSize.rawValue),
            interestImageView.heightAnchor.constraint(equalToConstant: UIConstants.imageSideSize.rawValue),
            interestImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            interestImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIConstants.leftInset.rawValue),
            
            enterButton.heightAnchor.constraint(equalToConstant: height),
            enterButton.widthAnchor.constraint(equalToConstant: UIConstants.buttonWidht.rawValue),
            enterButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            enterButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            enterNameTextField.centerYAnchor.constraint(equalTo: centerYAnchor),
            enterNameTextField.leadingAnchor.constraint(equalTo: interestImageView.trailingAnchor, constant: UIConstants.rightInset.rawValue),
            enterNameTextField.trailingAnchor.constraint(equalTo: enterButton.leadingAnchor, constant: -UIConstants.rightInset.rawValue),
        ])
    }
    
    func setupTargets() {
        enterButton.addTarget(self, action: #selector(addNewInterest), for: .touchUpInside)
    }
}