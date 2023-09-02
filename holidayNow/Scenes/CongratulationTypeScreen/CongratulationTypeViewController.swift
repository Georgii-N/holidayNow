import UIKit

final class CongratulationTypeViewController: UIViewController {
    
    // MARK: - UI:
    private lazy var buttonsStack: UIStackView = {
       let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        
        return stackView
    }()
    
    private var congratulationLenghLabel: UILabel = {
       let label = UILabel()
        label.font = .captionMediumBoldFont
        label.text = L10n.Congratulation.congratulationLengh
        
        return label
    }()
    
    private var lenghSlider: UISlider = {
       let slider = UISlider()
        slider.tintColor = .universalRed
        slider.thumbTintColor = .universalRed
        slider.maximumTrackTintColor = .black
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.value = 0.3
        
        return slider
    }()
    
    private lazy var textCongratulationButton = CongratulationTypeButton(buttonState: .text)
    private lazy var poetryCongratulationButton = CongratulationTypeButton(buttonState: .poetry)
    private lazy var haikuCongratulationButton = CongratulationTypeButton(buttonState: .haiku)
    private lazy var continueButton = BaseCustomButton(buttonState: .normal, ButtonText: L10n.Congratulation.contitnue)
    
    // MARK: - Lifecycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupTargets()
    }
}

// MARK: - CongratulationTypeButtonDelegate:
extension CongratulationTypeViewController: CongratulationTypeButtonDelegate {
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
        title = L10n.Congratulation.title
        view.backgroundColor = .white
        
        [textCongratulationButton, poetryCongratulationButton, haikuCongratulationButton].forEach {
            buttonsStack.addArrangedSubview($0)
            $0.delegate = self
        }
        
        [buttonsStack, congratulationLenghLabel, lenghSlider, continueButton].forEach {
            setupView($0)
        }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            buttonsStack.heightAnchor.constraint(equalToConstant: 240),
            buttonsStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            buttonsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            buttonsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            congratulationLenghLabel.topAnchor.constraint(equalTo: buttonsStack.bottomAnchor, constant: 100),
            congratulationLenghLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            lenghSlider.heightAnchor.constraint(equalToConstant: 5),
            lenghSlider.topAnchor.constraint(equalTo: congratulationLenghLabel.bottomAnchor, constant: 50),
            lenghSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            lenghSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            continueButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ])
        
        [textCongratulationButton, poetryCongratulationButton, haikuCongratulationButton].forEach {
            $0.leadingAnchor.constraint(equalTo: buttonsStack.leadingAnchor, constant: 20).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        }
    }
    
    func setupTargets() {
        
    }
}
