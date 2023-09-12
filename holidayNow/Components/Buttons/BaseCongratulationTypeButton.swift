import UIKit

enum BaseCongratulationButtonState {
    case text
    case poetry
    case haiku
    case none
}

final class BaseCongratulationTypeButton: UIView {
    
    // MARK: - Dependencies:
    weak var delegate: BaseCongratulationTypeButtonDelegate?
    
    // MARK: - Constants and Variables:
    var title: String {
        titleLabel.text ?? ""
    }
    
    var selectedState: Bool {
        isSelected
    }
    
    private let buttonState: BaseCongratulationButtonState
    private var isSelected = false {
        didSet {
            changeSelectionColor()
        }
    }
    
    // MARK: - UI:
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .captionMediumRegularFont
        
        return label
    }()
    
    private lazy var outsideCircleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.universalRed.cgColor
        
        return view
    }()
    
    private lazy var insideCircleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        
        return view
    }()
    
    private let buttonColor: UIColor = .white
    
    // MARK: - Lifecycle:
    init(buttonState: BaseCongratulationButtonState) {
        self.buttonState = buttonState
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
        setupButton()
        changeSelectionColor()
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
        changeSelectionState()
        
        delegate?.synchronizeOtherButtons(title: titleLabel.text ?? "",
                                          state: isSelected,
                                          buttonType: isSelected ? buttonState : .none)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        transform = .identity
        backgroundColor = buttonColor
    }
    
    // MARK: - Public Methods:
    func changeSelectionState() {
        isSelected = !isSelected
    }
    
    // MARK: - Private Methods:
    private func setupButton() {
        switch buttonState {
        case .text:
            titleLabel.text = L10n.Congratulation.Button.text
        case .poetry:
            titleLabel.text = L10n.Congratulation.Button.poetry
        case .haiku:
            titleLabel.text = L10n.Congratulation.Button.haiku
        default:
            return
        }
        
        layer.cornerRadius = 24
        backgroundColor = buttonColor
        
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = .zero
        layer.shadowRadius = 10
    }
    
    private func changeSelectionColor() {
        insideCircleView.backgroundColor = isSelected ? .universalRed : .white
    }
}

// MARK: - Setup Views:
extension BaseCongratulationTypeButton {
    private func setupViews() {
        [titleLabel, outsideCircleView, insideCircleView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 56),
            
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            
            outsideCircleView.heightAnchor.constraint(equalToConstant: 20),
            outsideCircleView.widthAnchor.constraint(equalToConstant: 20),
            outsideCircleView.centerYAnchor.constraint(equalTo: centerYAnchor),
            outsideCircleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            insideCircleView.heightAnchor.constraint(equalToConstant: 10),
            insideCircleView.widthAnchor.constraint(equalToConstant: 10),
            insideCircleView.centerXAnchor.constraint(equalTo: outsideCircleView.centerXAnchor),
            insideCircleView.centerYAnchor.constraint(equalTo: outsideCircleView.centerYAnchor),
        ])
    }
}
