import UIKit

final class BaseResultViewController: UIViewController {
    
    // MARK: - Constants and Variables
    private var titleScreen: String
    private var isBackButton: Bool
    private var buttonText: String?
    
    //MARK: - UI
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
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
    
    private lazy var customNavigationBar = BaseNavigationBar(title: titleScreen, isBackButton: isBackButton)
    private lazy var actionButton = BaseCustomButton(buttonState: .normal, ButtonText: buttonText ?? "")
    
    // MARK: - Lifecycle
    init(titleScreen: String, isBackButton: Bool, actionButtonText: String?) {
        self.titleScreen = titleScreen
        self.isBackButton = isBackButton
        self.buttonText = actionButtonText
        
        super.init(nibName: nil, bundle: nil)
        
        if buttonText == nil {
            actionButton.isHidden = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
}

// MARK: - Setup Views
private extension BaseResultViewController {
    func setupViews() {
        view.backgroundColor = .whiteDay
        
        [customNavigationBar, imageView, textLabel].forEach(view.setupView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            customNavigationBar.topAnchor.constraint(equalTo: view.topAnchor),
            customNavigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            customNavigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            imageView.topAnchor.constraint(equalTo: customNavigationBar.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            textLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16),
            textLabel.heightAnchor.constraint(equalToConstant: 500)
        ])
    }
}
