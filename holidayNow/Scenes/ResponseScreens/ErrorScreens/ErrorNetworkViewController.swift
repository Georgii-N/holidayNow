import UIKit

final class ErrorNetworkViewController: UIViewController {
    
    // MARK: - Dependencies:
    weak var coordinator: CoordinatorProtocol?
    
    // MARK: - Constants and Variables:
    private enum ErrorNetworkUIConstants {
        static let imageViewHeight: CGFloat = 220
        static let textLabelHeight: CGFloat = 100
    }
    
    // MARK: - UI
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = Resources.Images.ResponseScreens.responseNetworkError
        return imageView
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .bodyMediumRegularFont
        label.textColor = .blackDay
        label.text = L10n.ResultScreen.NetworkErrorText.var1
        return label
    }()
    
    private lazy var customNavigationBar = BaseNavigationBar(title: L10n.ResultScreen.title, isBackButton: true, coordinator: coordinator)
    private lazy var actionButton = BaseCustomButton(buttonState: .normal, buttonText: L10n.ResultScreen.repeatButton)
    
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
        setupTargets()
    }
    
    // MARK: - Objc Methods:
    @objc private func didTapActionButton() {
        coordinator?.removeAllviewControllers()
        coordinator?.goToFirstFormViewController()
    }
}

// MARK: - Setup Views
private extension ErrorNetworkViewController {
    func setupViews() {
        view.backgroundColor = .whiteDay
        customNavigationBar.setupNavigationBar(with: view, controller: self)
        
        [imageView, textLabel, actionButton].forEach(view.setupView)
    }
    
    func setupConstraints() {
        setupImageViewConstraints()
        setupTextLabelConstraints()
        setupActionButtonConstraints()
    }
    
    func setupImageViewConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: customNavigationBar.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: ErrorNetworkUIConstants.imageViewHeight)
            ])
    }
    
    func setupTextLabelConstraints() {
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: UIConstants.sideInset),
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.sideInset),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.sideInset),
            textLabel.heightAnchor.constraint(equalToConstant: ErrorNetworkUIConstants.textLabelHeight)
            ])
    }
    
    func setupActionButtonConstraints() {
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -UIConstants.blocksInset),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.sideInset),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.sideInset)
            ])
    }
    
    func setupTargets() {
        actionButton.addTarget(self, action: #selector(didTapActionButton), for: .touchUpInside)
    }
}
