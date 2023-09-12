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
        responseLabel.font = .bodyMediumBoldFont
        responseLabel.textColor = .blackDay
        responseLabel.numberOfLines = 0
        responseLabel.text = successViewModel.textResultObservable.wrappedValue
        responseLabel.textAlignment = .center
        
        return responseLabel
    }()
    
    private lazy var copyResponseButton: UIButton = {
        let button = UIButton()
        button.setImage(Resources.Images.ResponseScreens.contentCopyIcon, for: .normal)
        button.tintColor = .blackDay
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 27.5
        return button
    }()
    
    private lazy var backToStartButton = BaseCustomButton(buttonState: .back, buttonText: L10n.Success.BackToStartButton.title)
    private lazy var shareButton = BaseCustomButton(buttonState: .normal, buttonText: L10n.Success.ShareButton.title)
    private lazy var customNavigationBar = BaseNavigationBar(title: L10n.Congratulation.turn, isBackButton: false, coordinator: coordinator)
    
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
        copyResponseButton.isHidden = true
    }
    
    // MARK: - Objc Methods:
    @objc private func didTapGoToStartButton() {
        // TODO: - Дописать обнуление контроллеров в навбаре
        coordinator?.goToCongratulationTypeViewController()
    }
    
    @objc private func didTapShareButton() {
        let activityViewController = UIActivityViewController(activityItems: [responseLabel.text], applicationActivities: nil)
        present(activityViewController, animated: true)
    }
    
    @objc private func didTapCopyButton() {
        UIPasteboard.general.string = responseLabel.text
    }
}

// MARK: - Setup Views:
private extension SuccessViewController {
    func setupViews() {
        
        view.backgroundColor = .whiteDay
        
        customNavigationBar.setupNavigationBar(with: view, controller: self)
        
        [imageView,
         scrollView,
         copyResponseButton,
         backToStartButton,
         shareButton].forEach(view.setupView)
        
        scrollView.setupView(responseLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: customNavigationBar.bottomAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 220),
            
            scrollView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            scrollView.heightAnchor.constraint(equalToConstant: 250),
            
            responseLabel.topAnchor.constraint(equalTo: scrollView.topAnchor),
            responseLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            responseLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            responseLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            responseLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            
            copyResponseButton.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 20),
            copyResponseButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            copyResponseButton.heightAnchor.constraint(equalToConstant: 55),
            copyResponseButton.widthAnchor.constraint(equalToConstant: 55),
            
            backToStartButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -64),
            backToStartButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backToStartButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -8),
            
            shareButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -64),
            shareButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 8),
            shareButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
    
    func setupTargets() {
        copyResponseButton.addTarget(self, action: #selector(didTapCopyButton), for: .touchUpInside)
        backToStartButton.addTarget(self, action: #selector(didTapGoToStartButton), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(didTapShareButton), for: .touchUpInside)
    }
}



