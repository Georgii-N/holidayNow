import UIKit

final class BaseNavigationBar: UIView {
    
    //MARK: - UI
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .left
        titleLabel.font = .headerSmallBoldFont
        titleLabel.textColor = .blackDay
        return titleLabel
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "back"), for: .normal)
        return button
    }()
    
    // MARK: - Lifecycle
    init(title: String, isBackButton: Bool) {
        super.init(frame: .zero)
        self.titleLabel.text = title
        setupViews()
        setupConstraints()
        
        if !isBackButton {
            backButton.isHidden = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    func addTargetToBackButton(target: Any?, action: Selector, for event: UIControl.Event) {
        backButton.addTarget(target, action: action, for: event)
    }
}

// MARK: - Setup Views
private extension BaseNavigationBar {
    func setupViews() {
        self.backgroundColor = .whiteDay
        [titleLabel, backButton].forEach(setupView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 70),
            
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            backButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            backButton.widthAnchor.constraint(equalToConstant: 24),
            
            titleLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
