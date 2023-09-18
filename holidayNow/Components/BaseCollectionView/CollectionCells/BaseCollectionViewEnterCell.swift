import UIKit

final class BaseCollectionViewEnterCell: UICollectionViewCell {
    
    // MARK: - Dependencies:
    weak var delegate: BaseCollectionViewEnterCellDelegate?
    
    // MARK: - Constant and Variables:
    private enum EnterCellUIConstants {
        static let buttonWidht: CGFloat = 70
        static let leftInset: CGFloat = 10
        static let viewsInsets: CGFloat = 40
        static let cellRadius: CGFloat = 18
    }
    
    private let maximumCountOfInterests = 3
    private var interestCounter = 0 {
        didSet {
            if interestCounter == maximumCountOfInterests {
                controlStateButton(isBlock: true)
            }
        }
    }
    
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
        textField.font = .captionMediumRegularFont
        textField.placeholder = L10n.FirstForm.Interests.addMyOwn
        
        return textField
    }()
    
    private lazy var enterButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = EnterCellUIConstants.cellRadius
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
        
        changeButtonAppearance(isEnable: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods:
    func setupCellWidht(value: CGFloat) {
        let totalInsets = EnterCellUIConstants.leftInset + UIConstants.smallInset + EnterCellUIConstants.viewsInsets
        let elementWidht = UIConstants.sideSize + EnterCellUIConstants.buttonWidht
        
        cellWidht = value - totalInsets - elementWidht
    }
    
    func controlStateButton(isBlock: Bool) {
        if isBlock {
            enterNameTextField.isUserInteractionEnabled = false
            isUserInteractionEnabled = false
            changeButtonAppearance(isEnable: false)
            enterNameTextField.placeholder = L10n.FirstForm.Interests.noAvailable
        } else {
            if interestCounter != maximumCountOfInterests {
                enterNameTextField.isUserInteractionEnabled = true
                isUserInteractionEnabled = true
                enterNameTextField.placeholder = L10n.FirstForm.Interests.addMyOwn
            }
        }
    }
    
    // MARK: - Private Methods:
    private func changeButtonAppearance(isEnable: Bool) {
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
    @objc private func addNewTarget() {
        guard let text = enterNameTextField.text else { return }
        
        if text != "" {
            if ProhibitedDictionaryService().isWordProhibited(with: text) {
                delegate?.changeStateCellWarningLabel(isShow: true, isWrongText: true)
            } else {
                delegate?.addNewTarget(name: text)
                AnalyticsService.instance.trackAmplitudeEvent(with: "addNewInterest", params: ["name": text])
                delegate?.changeStateCellWarningLabel(isShow: false, isWrongText: false)
                
                interestCounter += 1
                
                enterNameTextField.text = nil
                enterNameTextField.resignFirstResponder()
                changeButtonAppearance(isEnable: false)
            }
        }
    }
}

// MARK: - UITextFieldDelegate
extension BaseCollectionViewEnterCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.length == 1 && !string.isEmpty || range.length == 1 && string.isEmpty && textField.text?.count == 1 {
            changeButtonAppearance(isEnable: false)
            delegate?.changeStateCellWarningLabel(isShow: false, isWrongText: false)
        } else {
            changeButtonAppearance(isEnable: true)
        }
        
        if let currentText = textField.text {
            guard let stringRange = Range(range, in: currentText) else { return false }
            let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
            let result = updatedText.count <= 15
            
            delegate?.changeStateCellWarningLabel(isShow: !result, isWrongText: false)
            
            return result
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        addNewTarget()
        
        return false
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        if textField.hasText {
            delegate?.changeStateCellWarningLabel(isShow: false, isWrongText: false)
            changeButtonAppearance(isEnable: false)
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if ProhibitedDictionaryService().isWordProhibited(with: textField.text ?? "") {
            delegate?.changeStateCellWarningLabel(isShow: true, isWrongText: true)
        }
    }
}

// MARK: - Setup Views:
private extension BaseCollectionViewEnterCell {
    func setupViews() {
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = EnterCellUIConstants.cellRadius
        
        [interestImageView, enterNameTextField, enterButton].forEach(setupView)
    }
    
    func setupConstraints() {
        let height = bounds.height
        
        setupInterestImageViewConstraints()
        setupEnterButtonConstraints(with: height)
        setupEnterNameTextFieldConstraints()
    }
    
    func setupInterestImageViewConstraints() {
        NSLayoutConstraint.activate([
            interestImageView.widthAnchor.constraint(equalToConstant: UIConstants.sideSize),
            interestImageView.heightAnchor.constraint(equalToConstant: UIConstants.sideSize),
            interestImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            interestImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: EnterCellUIConstants.leftInset)
            ])
    }
    
    func setupEnterButtonConstraints(with height: CGFloat) {
        NSLayoutConstraint.activate([
            enterButton.heightAnchor.constraint(equalToConstant: height),
            enterButton.widthAnchor.constraint(equalToConstant: EnterCellUIConstants.buttonWidht),
            enterButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            enterButton.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
    }
    
    func setupEnterNameTextFieldConstraints() {
        NSLayoutConstraint.activate([
            enterNameTextField.centerYAnchor.constraint(equalTo: centerYAnchor),
            enterNameTextField.leadingAnchor.constraint(equalTo: interestImageView.trailingAnchor, constant: UIConstants.smallInset),
            enterNameTextField.trailingAnchor.constraint(equalTo: enterButton.leadingAnchor, constant: -UIConstants.smallInset)
        ])
    }
    
    func setupTargets() {
        enterButton.addTarget(self, action: #selector(addNewTarget), for: .touchUpInside)
    }
}
