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
        label.font = .bodyMediumRegularFont
        label.text = L10n.Onboarding.description
        
        return label
    }()
    
    private lazy var onboardingDescriptionView = UIView()
    private lazy var onboardingStartButton = BaseCustomButton(buttonState: .normal,
                                                              buttonText: L10n.Onboarding.StartButton.title)
    
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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
    @objc private func switchToFirstFormVC() {
        coordinator?.goToFirstFormViewController()
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
        
        setupImageView(with: height)
        setupDescriptionView(with: height)
        setupTitleLabel()
        setupDescriptionLabel()
        setupStartButton()
    }
    
    func setupImageView(with height: CGFloat) {
        NSLayoutConstraint.activate([
            onboardingImageView.heightAnchor.constraint(equalToConstant: height * 0.7),
            onboardingImageView.topAnchor.constraint(equalTo: view.topAnchor),
            onboardingImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            onboardingImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }
    
    func setupDescriptionView(with height: CGFloat) {
        NSLayoutConstraint.activate([
            onboardingDescriptionView.topAnchor.constraint(equalTo: onboardingImageView.bottomAnchor, constant: -height * 0.2),
            onboardingDescriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            onboardingDescriptionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            onboardingDescriptionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ])
    }
    
    func setupTitleLabel() {
        NSLayoutConstraint.activate([
            onboardingTitleLabel.bottomAnchor.constraint(equalTo: onboardingDescriptionLabel.topAnchor, constant: -UIConstants.elementsInset),
            onboardingTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            onboardingTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.sideInset),
            onboardingTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.sideInset)
            ])
    }
    
    func setupDescriptionLabel() {
        NSLayoutConstraint.activate([
            onboardingDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.sideInset),
            onboardingDescriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.sideInset),
            onboardingDescriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            onboardingDescriptionLabel.bottomAnchor.constraint(equalTo: onboardingStartButton.topAnchor, constant: -UIConstants.blocksInset)
            ])
    }
    
    func setupStartButton() {
        NSLayoutConstraint.activate([
            onboardingStartButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.sideInset),
            onboardingStartButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.sideInset),
            onboardingStartButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -UIConstants.blocksInset)
        ])
    }
    
    func setupTargets() {
        onboardingStartButton.addTarget(self, action: #selector(switchToFirstFormVC), for: .touchUpInside)
    }
}
