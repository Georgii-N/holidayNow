import UIKit
import Lottie

final class WaitingViewController: UIViewController {
    
    // MARK: - Dependencies:
    weak var coordinator: CoordinatorProtocol?
    
    private var waitingViewModel: WaitingViewModelProtocol
    
    // MARK: - Constants and Variables:
    private enum CongratulationUIConstants {
        static let animationViewSide: CGFloat = 300
        static let textLabelHeight: CGFloat = 100
    }
    
    // MARK: - UI:
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .bodyMediumRegularFont
        label.textColor = .blackDay
        return label
    }()
    
    private lazy var customNavigationBar = BaseNavigationBar(title: L10n.ResultScreen.Waiting.title, isBackButton: true, coordinator: coordinator)
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
                AnalyticsService.instance.trackAmplitudeEvent(name: .goToSuccessScreen, params: nil)
                self.resumeOnMainThread(coordinator.goToSuccessResultViewController, with: ())
            } else {
                AnalyticsService.instance.trackAmplitudeEvent(name: .goToErrorScreen, params: nil)
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
        
        animationView.backgroundColor = .whiteDay
        
        customNavigationBar.setupNavigationBar(with: view, controller: self)
        [textLabel, animationView].forEach(view.setupView)
    }
    
    func setupConstraints() {
        setupAnimationViewConstraints()
        setupTextLabelConstraints()
    }
    
    func setupAnimationViewConstraints() {
        NSLayoutConstraint.activate([
            animationView.topAnchor.constraint(equalTo: customNavigationBar.bottomAnchor, constant: UIConstants.sideInset),
            animationView.heightAnchor.constraint(equalToConstant: CongratulationUIConstants.animationViewSide),
            animationView.widthAnchor.constraint(equalToConstant: CongratulationUIConstants.animationViewSide),
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: UIConstants.sideInset)])
    }
    
    func setupTextLabelConstraints() {
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: animationView.bottomAnchor, constant: UIConstants.blocksInset),
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.sideInset),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.sideInset),
            textLabel.heightAnchor.constraint(equalToConstant: CongratulationUIConstants.textLabelHeight)
        ])
    }
    
    func setupAnimation() {
        animationView.play()
        animationView.loopMode = .loop
    }
}
