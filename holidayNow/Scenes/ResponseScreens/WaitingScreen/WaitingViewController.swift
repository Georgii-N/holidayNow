import UIKit
import Lottie

final class WaitingViewController: UIViewController {
    
    // MARK: - Dependencies:
    weak var coordinator: CoordinatorProtocol?
    
    private var waitingViewModel: WaitingViewModelProtocol
    
    //MARK: - UI
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .bodyExtraLargeBoldFont
        label.textColor = .blackDay
        return label
    }()
    
    private lazy var customNavigationBar = BaseNavigationBar(title: L10n.ResultScreen.title, isBackButton: true, coordinator: coordinator)
    private lazy var animationView = LottieAnimationView(name: "magic")
    
    
    // MARK: - LifeCycle:
    init(coordinator: CoordinatorProtocol?, waitingViewModel: WaitingViewModelProtocol) {
        self.waitingViewModel = waitingViewModel
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
        setupAnimation()
        bind()
    }
    
    // MARK: - Private Methods:
    private func bind() {
        waitingViewModel.isResponseSuccessObservable.bind { [weak self] isSuccess in
            guard
                let isSuccess,
                let self,
                let coordinator
            else { return }
            
            if isSuccess {
                self.resumeOnMainThread(coordinator.goToSuccessResultViewController, with: ())
            } else {
                self.resumeOnMainThread(coordinator.goToErrorNetworkViewController, with: ())
            }
        }
    }
}

// MARK: - Setup Views
private extension WaitingViewController {
    func setupViews() {
        view.backgroundColor = .whiteDay
        
        imageView.image = waitingViewModel.getRandomImage()
        textLabel.text = waitingViewModel.getRandomText()
        
        customNavigationBar.setupNavigationBar(with: view, controller: self)
        [imageView, textLabel, animationView].forEach(view.setupView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: customNavigationBar.bottomAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 220),
            
            textLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textLabel.heightAnchor.constraint(equalToConstant: 100),
            
            animationView.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 20),
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.heightAnchor.constraint(equalToConstant: 200),
            animationView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func setupAnimation() {
        animationView.play()
        animationView.loopMode = .loop
    }
}
