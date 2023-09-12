import UIKit

final class ErrorAPIViewController: UIViewController {
    
    // MARK: - Dependencies:
    weak var coordinator: CoordinatorProtocol?
    
    // MARK: - Constants and Variables
    private var buttonText: String?
    
    //MARK: - UI
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = Resources.Images.ResponseScreens.responseAIError
        return imageView
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .bodyMediumRegularFont
        label.textColor = .blackDay
        label.text = L10n.ResultScreen.APIErrorText.var1
        return label
    }()
    
    private lazy var customNavigationBar = BaseNavigationBar(title: L10n.ResultScreen.title, isBackButton: true, coordinator: coordinator)
    private lazy var actionButton = BaseCustomButton(buttonState: .normal, buttonText: L10n.ResultScreen.goToStart)
    
    // MARK: - Lifecycle
    init(coordinator: CoordinatorProtocol?) {
        super.init(nibName: nil, bundle: nil)
        self.coordinator = coordinator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Objc Methods:
    @objc private func didTapActionButton() {
        coordinator?.goToFirstFormViewController()
    }
}

// MARK: - Setup Views
private extension ErrorAPIViewController {
    func setupViews() {
        view.backgroundColor = .whiteDay
        customNavigationBar.setupNavigationBar(with: view, controller: self)
        
        [imageView, textLabel, actionButton].forEach(view.setupView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: customNavigationBar.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 220),
            
            textLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textLabel.heightAnchor.constraint(equalToConstant: 100),
            
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    func setupTargets() {
        actionButton.addTarget(self, action: #selector(didTapActionButton), for: .touchUpInside)
    }
}
