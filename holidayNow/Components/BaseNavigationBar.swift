import UIKit

final class BaseNavigationBar: UIView {
    
    // MARK: - Dependencies:
    weak var coordinator: CoordinatorProtocol?
    
    // MARK: - Constants and Variables:
    private enum NavigationUIConstants {
        static let barsHeight: CGFloat = 56
        static let navigationBarBackButtonSide: CGFloat = 24
        static let navigationBarBackButtonLeftInset: CGFloat = 16
    }
    
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
            bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: NavigationUIConstants.barsHeight),
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
        let isHidden = backButton.isHidden
        
        setupBackButtonConstraints(with: view)
        setupTitleLabelConstraints(isButtonHidden: isHidden)
    }
    
    func setupBackButtonConstraints(with view: UIView) {
        NSLayoutConstraint.activate([
            backButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: NavigationUIConstants.barsHeight / 2),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: NavigationUIConstants.navigationBarBackButtonLeftInset),
            backButton.heightAnchor.constraint(equalToConstant: NavigationUIConstants.navigationBarBackButtonSide),
            backButton.widthAnchor.constraint(equalToConstant: NavigationUIConstants.navigationBarBackButtonSide)
        ])
    }
    
    func setupTitleLabelConstraints(isButtonHidden: Bool) {
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: isButtonHidden ? leadingAnchor : backButton.trailingAnchor, constant: UIConstants.sideInset),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func setupTargets() {
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
    }
}
