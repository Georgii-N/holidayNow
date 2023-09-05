import UIKit

final class OnboardingViewController: UIViewController {
    
    // MARK: - Dependencies
    weak var coordinator: CoordinatorProtocol?
    
    // MARK: - UI:
    private lazy var onboardingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = Resources.Images.Onboarding.onboardingImage
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .gray
        
        return imageView
    }()
        
    private lazy var onboardingTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = .headerLargeBoldFont
        label.text = L10n.Onboarding.title
        
        return label
    }()
    
    private lazy var onboardingDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .white
        label.font = .bodyLargeRegularFont
        label.text = L10n.Onboarding.description
        
        return label
    }()
    
    private lazy var onboardingDescriptionView = UIView()
    private lazy var onboardingStartButton = BaseCustomButton(buttonState: .normal,
                                                              ButtonText: L10n.Onboarding.StartButton.title)
    
    // MARK: - LifeCycle:
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupGradient()
    }
    
    // MARK: - Private Methods:
    private func setupGradient() {
        let gradient = CAGradientLayer()
        
        gradient.frame = CGRect(x: 0, y: 0, width: onboardingDescriptionView.bounds.width,
                                            height: onboardingDescriptionView.bounds.height)
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradient.startPoint = CGPoint(x: 1, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0.35)
        onboardingDescriptionView.layer.insertSublayer(gradient, at: 0)
    }
    
    // MARK: - Objc Methods:
    @objc private func switchToSelectCongratulationTypeVC() {
        coordinator?.goToCongratulationTypeViewController()
    }
}

// MARK: - Setup Views:
private extension OnboardingViewController {
    func setupViews() {
        view.backgroundColor = .blackDay
        
        [onboardingImageView, onboardingDescriptionView].forEach(view.setupView)
        [onboardingTitleLabel,onboardingDescriptionLabel, onboardingStartButton].forEach(onboardingDescriptionView.setupView)
    }
    
    func setupConstraints() {
        let height = view.frame.height
        
        NSLayoutConstraint.activate([
            onboardingImageView.heightAnchor.constraint(equalToConstant: height * 0.7),
            onboardingImageView.topAnchor.constraint(equalTo: view.topAnchor),
            onboardingImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            onboardingImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            onboardingDescriptionView.topAnchor.constraint(equalTo: onboardingImageView.bottomAnchor, constant: -height * 0.2),
            onboardingDescriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            onboardingDescriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            onboardingDescriptionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            onboardingTitleLabel.topAnchor.constraint(equalTo: view.centerYAnchor, constant: height * 0.1),
            onboardingTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            onboardingTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
        
            onboardingDescriptionLabel.topAnchor.constraint(equalTo: onboardingTitleLabel.bottomAnchor, constant: 10),
            onboardingDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            onboardingDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            onboardingStartButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            onboardingStartButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            onboardingStartButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ])
    }
    
    func setupTargets() {
        onboardingStartButton.addTarget(self, action: #selector(switchToSelectCongratulationTypeVC), for: .touchUpInside)
    }
}
