import UIKit

enum BaseCongratulationButtonState {
    case text
    case poetry
}

final class BaseCongratulationTypeButton: UIView {
    
    // MARK: - Dependencies:
    weak var delegate: BaseCongratulationTypeButtonDelegate?
    
    // MARK: - Constants and Variables:
    private enum CongratulationButtonUIConstants {
        static let buttonRadius: CGFloat = 24
        static let buttonOutsideViewRadius: CGFloat = 10
        static let buttonInsideViewRadius: CGFloat = 5
        static let titleRightInset: CGFloat = 50
        static let insideViewInset: CGFloat = 10
    }
    
    var title: String {
        titleLabel.text ?? ""
    }
    
    private(set) var buttonState: BaseCongratulationButtonState
    private(set) var isSelected = false {
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
        view.layer.cornerRadius = CongratulationButtonUIConstants.buttonOutsideViewRadius
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.universalRed.cgColor
        
        return view
    }()
    
    private lazy var insideCircleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = CongratulationButtonUIConstants.buttonInsideViewRadius
        
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
        
        if !isSelected {
            changeSelectionState()
            
            delegate?.synchronizeOtherButtons(title: titleLabel.text ?? "",
                                              state: isSelected,
                                              buttonType: buttonState)
        }
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
        }
        
        layer.cornerRadius = CongratulationButtonUIConstants.buttonRadius
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
        heightAnchor.constraint(equalToConstant: UIConstants.buttonHeight).isActive = true
        
        setupTitleLabelConstraints()
        setupOutsideCircleViewConstraints()
        setupInsideCircleViewConstraints()
    }
    
    func setupTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: UIConstants.sideInset),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -CongratulationButtonUIConstants.titleRightInset)
        ])
    }
    
    func setupOutsideCircleViewConstraints() {
        NSLayoutConstraint.activate([
            outsideCircleView.heightAnchor.constraint(equalToConstant: UIConstants.sideInset),
            outsideCircleView.widthAnchor.constraint(equalToConstant: UIConstants.sideInset),
            outsideCircleView.centerYAnchor.constraint(equalTo: centerYAnchor),
            outsideCircleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -UIConstants.sideInset)
        ])
    }
    
    func setupInsideCircleViewConstraints() {
        NSLayoutConstraint.activate([
            insideCircleView.heightAnchor.constraint(equalToConstant: CongratulationButtonUIConstants.insideViewInset),
            insideCircleView.widthAnchor.constraint(equalToConstant: CongratulationButtonUIConstants.insideViewInset),
            insideCircleView.centerXAnchor.constraint(equalTo: outsideCircleView.centerXAnchor),
            insideCircleView.centerYAnchor.constraint(equalTo: outsideCircleView.centerYAnchor)
        ])
    }
}
