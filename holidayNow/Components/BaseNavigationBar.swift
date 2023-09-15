import UIKit

final class BaseNavigationBar: UIView {
    
    // MARK: - Dependencies:
    weak var coordinator: CoordinatorProtocol?
    
    // MARK: - UI:
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .left
        titleLabel.font = .captionMediumBoldFont
        titleLabel.textColor = .blackDay
        return titleLabel
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(Resources.Images.NavigationBar.backButtonIcon, for: .normal)
        return button
    }()
    
    // MARK: - Lifecycle:
    init(title: String, isBackButton: Bool, coordinator: CoordinatorProtocol?) {
        super.init(frame: .zero)
        self.titleLabel.text = title
        self.coordinator = coordinator
        
        if !isBackButton {
            backButton.isHidden = true
        }
        
        setupViews()
        setupTargets()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods:
    func setupNavigationBar(with view: UIView, controller: UIViewController) {
        view.setupView(self)
    
        controller.navigationController?.navigationBar.isHidden = true
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor),
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 56),
            trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        setupConstraints(view: view)
    }
    
    // MARK: - Objc Methods:
    @objc private func goBack() {
        coordinator?.goBack()
    }
}

// MARK: - Setup Views:
private extension BaseNavigationBar {
    func setupViews() {
        self.backgroundColor = .whiteDay
        [titleLabel, backButton].forEach(setupView)
        
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = .zero
        layer.shadowRadius = 10
    }
    
    func setupConstraints(view: UIView) {
        let height: CGFloat = 56
        let isHidden = backButton.isHidden
        
        NSLayoutConstraint.activate([            
            backButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: height / 2),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            backButton.heightAnchor.constraint(equalToConstant: 24),
            backButton.widthAnchor.constraint(equalToConstant: 24),
            
            titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: isHidden ? leadingAnchor : backButton.trailingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func setupTargets() {
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
    }
}
