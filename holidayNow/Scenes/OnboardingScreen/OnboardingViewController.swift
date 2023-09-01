import UIKit

final class OnboardingViewController: UIViewController {
    
    // MARK: - UI:
    private lazy var onboardingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Resources.Images.onboardingImage
        imageView.layer.cornerRadius = 12
        imageView.backgroundColor = .gray
        
        return imageView
    }()
    
    private lazy var onboardintTitleLabel: UILabel = {
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
    
    private lazy var onboardintStartButton = BaseCustomButton(buttonState: .normal,
                                                              ButtonText: L10n.Onboarding.StartButton.title)
    
    // MARK: - LifeCycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupTargets()
    }
}

// MARK: - Setup Views:
private extension OnboardingViewController {
    func setupViews() {
        view.backgroundColor = .whiteDay
        
        setupView(onboardingImageView)
        setupView(onboardintTitleLabel)
        setupView(onboardingDescriptionLabel)
        setupView(onboardintStartButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            onboardingImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            onboardingImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            onboardingImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            onboardingImageView.bottomAnchor.constraint(equalTo: view.centerYAnchor),
            
            onboardintTitleLabel.topAnchor.constraint(equalTo: onboardingImageView.bottomAnchor, constant: 20),
            onboardintTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            onboardintTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
        
            onboardingDescriptionLabel.topAnchor.constraint(equalTo: onboardintTitleLabel.bottomAnchor, constant: 30),
            onboardingDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            onboardingDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            
            onboardintStartButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            onboardintStartButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            onboardintStartButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ])
    }
    
    func setupTargets() {
        
    }
}
