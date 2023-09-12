import UIKit
import Lottie

final class WaitingViewController: UIViewController {
    
    // MARK: - Dependencies:
    weak var coordinator: CoordinatorProtocol?
    
    private var waitingViewModel: WaitingViewModelProtocol
    
    //MARK: - UI:
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .bodyMediumRegularFont
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
        textLabel.text = waitingViewModel.getRandomText()
        
        customNavigationBar.setupNavigationBar(with: view, controller: self)
        [textLabel, animationView].forEach(view.setupView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            animationView.topAnchor.constraint(equalTo: customNavigationBar.bottomAnchor),
            animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            animationView.heightAnchor.constraint(equalToConstant: 400),
            
            textLabel.topAnchor.constraint(equalTo: animationView.bottomAnchor, constant: 20),
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textLabel.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func setupAnimation() {
        animationView.play()
        animationView.loopMode = .loop
    }
}
