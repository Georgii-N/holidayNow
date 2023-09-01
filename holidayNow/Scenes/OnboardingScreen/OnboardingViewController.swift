import UIKit

final class OnboardingViewController: UIViewController {
    
    // MARK: - UI:
    private lazy var onboardingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Resources.Images.onboardingImage
        imageView.layer.cornerRadius = 25
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .gray
        
        return imageView
    }()
    
    private lazy var onboardingTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .headerLargeBoldFont
        label.text = L10n.Onboarding.title
        
        return label
    }()
    
    private lazy var onboardingDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .bodyLargeRegularFont
        label.text = L10n.Onboarding.description
        
        return label
    }()
    
    private lazy var onboardingStartButton = BaseCustomButton(buttonState: .normal,
                                                              ButtonText: L10n.Onboarding.StartButton.title)
    
    // MARK: - LifeCycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupTargets()
    }
    
    // MARK: - Objc Methods:
    @objc private func switchToSelectCongratulationTypeVC() {
        let viewController = CongratulationTypeViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .overFullScreen
    
        present(navigationController, animated: true)
    }
}

// MARK: - Setup Views:
private extension OnboardingViewController {
    func setupViews() {
        view.backgroundColor = .whiteDay
        
        [onboardingImageView, onboardingTitleLabel, onboardingDescriptionLabel, onboardingStartButton].forEach {
            setupView($0)
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            onboardingImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            onboardingImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            onboardingImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            onboardingImageView.bottomAnchor.constraint(equalTo: view.centerYAnchor),
            
            onboardingTitleLabel.topAnchor.constraint(equalTo: onboardingImageView.bottomAnchor, constant: 20),
            onboardingTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            onboardingTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
        
            onboardingDescriptionLabel.topAnchor.constraint(equalTo: onboardingTitleLabel.bottomAnchor, constant: 30),
            onboardingDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            onboardingDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            onboardingStartButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            onboardingStartButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            onboardingStartButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ])
    }
    
    func setupTargets() {
        onboardingStartButton.setTarget(action: switchToSelectCongratulationTypeVC)
    }
}
