import UIKit

final class BaseCustomButton: UIButton {
    
    // MARK: - Constants and Variables:
    enum ButtonState {
        case normal
        case back
    }
    
    //MARK: - UI:
    private var buttonState: ButtonState
    private var ButtonText: String
    private var buttonColor: UIColor?
    private var buttonTextColor: UIColor?
    
    // MARK: - Lifecycle:
    init(buttonState: ButtonState, buttonText: String) {
        self.buttonState = buttonState
        self.ButtonText = buttonText
        super.init(frame: .zero)
        setupConstraints()
        setupButton()        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override Methods:
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        backgroundColor = backgroundColor?.withAlphaComponent(0.8)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        transform = .identity
        backgroundColor = buttonColor
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        transform = .identity
        backgroundColor = buttonColor
    }
    
    // MARK: - Public Methods:
    func block() {
        backgroundColor = .lightGray
        setTitleColor(.black, for: .normal)
        isUserInteractionEnabled = false
    }
    
    func unblock() {
        backgroundColor = buttonColor
        setTitleColor(buttonTextColor, for: .normal)
        isUserInteractionEnabled = true
    }
    
    // MARK: - Private Methods:
    private func setupButton() {
        switch buttonState {
        case .normal:
            buttonColor = .universalRed
            buttonTextColor = .white
        case .back:
            buttonColor = .lightGray
            buttonTextColor = .black
        }
        
        layer.cornerRadius = 24
        backgroundColor = buttonColor
        setTitle(ButtonText, for: .normal)
        setTitleColor(buttonTextColor, for: .normal)
        titleLabel?.font = .captionMediumBoldFont
    }
}

// MARK: - Setup Views
private extension BaseCustomButton {
    func setupConstraints() {
        heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
