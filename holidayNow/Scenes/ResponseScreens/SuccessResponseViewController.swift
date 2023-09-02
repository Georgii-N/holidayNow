import UIKit

final class SuccessViewController: UIViewController {
    
    // MARK: - UI:
    private lazy var resultLabel = BaseResultLabel(text: L10n.Success.result)
    
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
        responseLabel.text = "Сегодня наш праздник — День Бани! Пусть даже самое обыденное событие становится особенным в этот день, ведь баня — это место, где мы находим не только тепло и чистоту, но и настоящую душевную близость и отдых от повседневных забот."
        responseLabel.textAlignment = .center
        return responseLabel
    }()
    
    private lazy var copyResponseButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "doc.on.doc"), for: .normal)
        button.tintColor = .blackDay
        return button
    }()
    
    private lazy var backToStartButton = BaseCustomButton(buttonState: .back, ButtonText: L10n.Success.BackToStartButton.title)
    private lazy var shareButton = BaseCustomButton(buttonState: .normal, ButtonText: L10n.Success.ShareButton.title)
    
    // MARK: - LifeCycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupTargets()
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
         shareButton].forEach(self.setupView)
        
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
        
    }
}



