import UIKit

final class SuccessViewController: UIViewController {
    
    // MARK: - Dependencies
    weak var coordinator: CoordinatorProtocol?
    private var successViewModel: SuccessViewModelProtocol
    
    // MARK: - UI:
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = Resources.Images.ResponseScreens.responseSuccess
        return imageView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.isScrollEnabled = true

        return scrollView
    }()
    
    private lazy var responseLabel: UILabel = {
        let responseLabel = UILabel()
        responseLabel.font = .bodyMediumRegularFont
        responseLabel.textColor = .blackDay
        responseLabel.numberOfLines = 0
        responseLabel.text = successViewModel.textResultObservable.wrappedValue
        responseLabel.textAlignment = .center
        
        return responseLabel
    }()
    
    private lazy var backToStartButton = BaseCustomButton(buttonState: .back, buttonText: L10n.Success.BackToStartButton.title)
    private lazy var shareButton = BaseCustomButton(buttonState: .normal, buttonText: L10n.Success.ShareButton.title)
    private lazy var customNavigationBar = BaseNavigationBar(title: L10n.ResultScreen.title, isBackButton: false, coordinator: coordinator)
    
    // MARK: - LifeCycle:
    init(coordinator: CoordinatorProtocol?, successViewModel: SuccessViewModelProtocol) {
        self.successViewModel = successViewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
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
    @objc private func didTapGoToStartButton() {
        coordinator?.goToFirstFormViewController()
        coordinator?.removeAllviewControllers()
    }
    
    @objc private func didTapShareButton() {
        guard let response = responseLabel.text else { return }
        let activityViewController = UIActivityViewController(
            activityItems: [response],
            applicationActivities: nil)
        
        present(activityViewController, animated: true)
    }
}

// MARK: - Setup Views:
private extension SuccessViewController {
    func setupViews() {
        
        view.backgroundColor = .whiteDay
        
        customNavigationBar.setupNavigationBar(with: view, controller: self)
        
        [imageView,
         scrollView,
         backToStartButton,
         shareButton].forEach(view.setupView)
        
        scrollView.setupView(responseLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: customNavigationBar.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 220),
            
            scrollView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            scrollView.bottomAnchor.constraint(equalTo: backToStartButton.topAnchor, constant: -20),
            
            responseLabel.topAnchor.constraint(equalTo: scrollView.topAnchor),
            responseLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            responseLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            responseLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            responseLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            backToStartButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            backToStartButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backToStartButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -10),
            
            shareButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            shareButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 10),
            shareButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    func setupTargets() {
        backToStartButton.addTarget(self, action: #selector(didTapGoToStartButton), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(didTapShareButton), for: .touchUpInside)
    }
}



