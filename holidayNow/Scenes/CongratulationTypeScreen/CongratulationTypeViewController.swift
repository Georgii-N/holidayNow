import UIKit

final class CongratulationTypeViewController: UIViewController {
    
    // MARK: - Dependencies
    weak var coordinator: CoordinatorProtocol?
    
    // MARK: - UI:
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.font = .captionMediumRegularFont
        label.textColor = .gray
        label.text = L10n.Congratulation.title
        
        return label
    }()
    
    private lazy var buttonsStack: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        
        return stackView
    }()
    
    private lazy var congratulationLenghLabel: UILabel = {
       let label = UILabel()
        label.font = .captionMediumBoldFont
        label.text = L10n.Congratulation.congratulationLengh
        
        return label
    }()
    
    private lazy var lenghSlider: UISlider = {
       let slider = UISlider()
        slider.tintColor = .universalRed
        slider.thumbTintColor = .universalRed
        slider.maximumTrackTintColor = .black
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.value = 0.3
        
        return slider
    }()
    
    private lazy var textCongratulationButton = BaseCongratulationTypeButton(buttonState: .text)
    private lazy var poetryCongratulationButton = BaseCongratulationTypeButton(buttonState: .poetry)
    private lazy var haikuCongratulationButton = BaseCongratulationTypeButton(buttonState: .haiku)
    private lazy var continueButton = BaseCustomButton(buttonState: .normal, buttonText: L10n.Congratulation.continue)
    
    // MARK: - Lifecycle:
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
    
    // MARK: - Objc Methods:
    @objc private func switchToFirstFormVC() {
        coordinator?.goToFirstFormViewController()
    }
}

// MARK: - CongratulationTypeButtonDelegate:
extension CongratulationTypeViewController: BaseCongratulationTypeButtonDelegate {
    func synchronizeOtherButtons(title: String, state: Bool) {
        [textCongratulationButton, poetryCongratulationButton, haikuCongratulationButton].forEach {
            if $0.title != title && $0.selectedState == state {
                $0.changeSelectionState()
            }
        }
    }
}

// MARK: - Setup Views:
private extension CongratulationTypeViewController {
    func setupViews() {
        view.backgroundColor = .white
        
        [textCongratulationButton, poetryCongratulationButton, haikuCongratulationButton].forEach {
            buttonsStack.addArrangedSubview($0)
            $0.delegate = self
        }
        
        [titleLabel, buttonsStack, congratulationLenghLabel, lenghSlider, continueButton].forEach(view.setupView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            buttonsStack.heightAnchor.constraint(equalToConstant: 240),
            buttonsStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            buttonsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            buttonsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            congratulationLenghLabel.topAnchor.constraint(equalTo: buttonsStack.bottomAnchor, constant: 100),
            congratulationLenghLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            lenghSlider.heightAnchor.constraint(equalToConstant: 5),
            lenghSlider.topAnchor.constraint(equalTo: congratulationLenghLabel.bottomAnchor, constant: 50),
            
            continueButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ])
        
        [titleLabel, textCongratulationButton, poetryCongratulationButton, haikuCongratulationButton].forEach {
            $0.leadingAnchor.constraint(equalTo: buttonsStack.leadingAnchor, constant: 20).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        }
        
        [lenghSlider, continueButton].forEach {
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        }
    }
    
    func setupTargets() {
        continueButton.addTarget(self, action: #selector(switchToFirstFormVC), for: .touchUpInside)
    }
}
