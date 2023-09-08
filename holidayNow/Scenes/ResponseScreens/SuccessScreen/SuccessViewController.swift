import UIKit

final class SuccessViewController: UIViewController {
    
    // MARK: - Dependencies
    weak var coordinator: CoordinatorProtocol?
    private var successViewModel: SuccessViewModelProtocol
    
    // MARK: - UI:
    private lazy var resultView: UIView = {
        let resultView = UIView()
        resultView.backgroundColor = .lightUniversalRed
        resultView.layer.cornerRadius = 24
        return resultView
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
    
    private lazy var copyResponseButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "doc.on.doc"), for: .normal)
        button.tintColor = .blackDay
        return button
    }()
    
    private lazy var resultLabel = BaseResultLabel(text: L10n.Success.result)
    private lazy var backToStartButton = BaseCustomButton(buttonState: .back, buttonText: L10n.Success.BackToStartButton.title)
    private lazy var shareButton = BaseCustomButton(buttonState: .normal, buttonText: L10n.Success.ShareButton.title)
    
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
    // TODO: - Дописать обнуление контроллеров в навбаре
        coordinator?.goToCongratulationTypeViewController()
    }
    
    @objc private func didTapShareButton() {
        let activityViewController = UIActivityViewController(activityItems: [successViewModel.textResultObservable], applicationActivities: nil)
        present(activityViewController, animated: true)
    }
}

// MARK: - Setup Views:
private extension SuccessViewController {
    func setupViews() {
        view.backgroundColor = .whiteDay
        [resultLabel,
         resultView,
         responseLabel,
         copyResponseButton,
         backToStartButton,
         shareButton].forEach(view.setupView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            resultLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            resultView.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 20),
            resultView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            resultView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            responseLabel.topAnchor.constraint(equalTo: resultView.topAnchor, constant: 16),
            responseLabel.leadingAnchor.constraint(equalTo: resultView.leadingAnchor, constant: 16),
            responseLabel.trailingAnchor.constraint(equalTo: resultView.trailingAnchor, constant: -16),
            
            copyResponseButton.topAnchor.constraint(equalTo: responseLabel.bottomAnchor, constant: 16),
            copyResponseButton.trailingAnchor.constraint(equalTo: resultView.trailingAnchor, constant: -16),
            copyResponseButton.bottomAnchor.constraint(equalTo: resultView.bottomAnchor, constant: -16),
            
            backToStartButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -64),
            backToStartButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            backToStartButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -8),
            
            shareButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -64),
            shareButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 8),
            shareButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
    
    func setupTargets() {
        backToStartButton.addTarget(self, action: #selector(didTapGoToStartButton), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(didTapShareButton), for: .touchUpInside)
    }
}



