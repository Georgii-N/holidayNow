import UIKit

final class OnboardingViewController: UIViewController {
    
    // MARK: - Dependencies
    weak var coordinator: CoordinatorProtocol?
    
    // MARK: Constants and Variables:
    private let onboardingCornerRadius: CGFloat = 25
    
    // MARK: - UI:
    private lazy var onboardingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = Resources.Images.Onboarding.onboardingImage
        imageView.layer.cornerRadius = onboardingCornerRadius
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
        
        setupImageViewConstraints(with: height)
        setupDescriptionViewConstraints(with: height)
        setupTitleLabelConstraints()
        setupDescriptionLabelConstraints()
        setupStartButtonConstraints()
        
        [onboardingImageView, onboardingDescriptionView].forEach {
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        }
        
        [onboardingTitleLabel, onboardingDescriptionLabel, onboardingStartButton].forEach {
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.sideInset).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.sideInset).isActive = true
        }
    }
    
    func setupImageViewConstraints(with height: CGFloat) {
        NSLayoutConstraint.activate([
            onboardingImageView.heightAnchor.constraint(equalToConstant: height * 0.7),
            onboardingImageView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
    }
    
    func setupDescriptionViewConstraints(with height: CGFloat) {
        NSLayoutConstraint.activate([
            onboardingDescriptionView.topAnchor.constraint(equalTo: onboardingImageView.bottomAnchor, constant: -height * 0.2),
            onboardingDescriptionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupTitleLabelConstraints() {
        NSLayoutConstraint.activate([
            onboardingTitleLabel.bottomAnchor.constraint(equalTo: onboardingDescriptionLabel.topAnchor, constant: -UIConstants.elementsInset),
            onboardingTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func setupDescriptionLabelConstraints() {
        NSLayoutConstraint.activate([
            onboardingDescriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            onboardingDescriptionLabel.bottomAnchor.constraint(equalTo: onboardingStartButton.topAnchor, constant: -UIConstants.blocksInset)
        ])
    }
    
    func setupStartButtonConstraints() {
        NSLayoutConstraint.activate([
            onboardingStartButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -UIConstants.blocksInset)
        ])
    }
    
    func setupTargets() {
        onboardingStartButton.addTarget(self, action: #selector(switchToFirstFormVC), for: .touchUpInside)
    }
}
