import UIKit

final class CongratulationTypeViewController: UIViewController {
    
    // MARK: - Dependencies
    weak var coordinator: CoordinatorProtocol?
    
    private var viewModel: CongratulationTypeViewModelProtocol
    
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
    
    private lazy var numberOfSentensesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        return stackView
    }()
    
    private lazy var minCountOfSentensesLabel: UILabel = {
        let label = UILabel()
        label.font = .bodyExtraSmallRegularFont
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var maxCountOfSentensesLabel: UILabel = {
        let label = UILabel()
        label.font = .bodyExtraSmallRegularFont
        label.textAlignment = .right
        
        return label
    }()
    
    private lazy var textCongratulationButton = BaseCongratulationTypeButton(buttonState: .text)
    private lazy var poetryCongratulationButton = BaseCongratulationTypeButton(buttonState: .poetry)
    private lazy var haikuCongratulationButton = BaseCongratulationTypeButton(buttonState: .haiku)
    private lazy var continueButton = BaseCustomButton(buttonState: .normal, buttonText: L10n.Congratulation.continue)
    
    // MARK: - Lifecycle:
    init(coordinator: CoordinatorProtocol?, viewModel: CongratulationTypeViewModelProtocol) {
        self.coordinator = coordinator
        self.viewModel = viewModel
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
        
        continueButton.block()
    }
    
    // MARK: - Private Methods:
    private func setupSentensesNumberLabel(with type: BaseCongratulationButtonState) {
        let minNumber: String
        var maxNumber: String
        
        continueButton.unblock()
        
        switch type {
        case .text:
            minNumber = Resources.Strings.congratulationMinSliderValue
            maxNumber = Resources.Strings.congratulationMaxSliderValue
        case .poetry:
            minNumber = Resources.Strings.congratulationMinSliderValue
            maxNumber = Resources.Strings.congratulationMediumSliderValue
        case .haiku:
            minNumber = Resources.Strings.congratulationMinSliderValue
            maxNumber = Resources.Strings.congratulationMediumSliderValue
        case .none:
            minNumber = ""
            maxNumber = ""
            continueButton.block()
        }
        
        minCountOfSentensesLabel.text = minNumber
        maxCountOfSentensesLabel.text = maxNumber
    }
    
    // MARK: - Objc Methods:
    @objc private func switchToFirstFormVC() {
        coordinator?.goToFirstFormViewController()
    }
    
    @objc private func setupCurrentSentensesValue() {
        viewModel.setupGreetingsLength(with: Int(lenghSlider.value))
    }
}

// MARK: - CongratulationTypeButtonDelegate:
extension CongratulationTypeViewController: BaseCongratulationTypeButtonDelegate {
    func synchronizeOtherButtons(title: String, state: Bool, buttonType: BaseCongratulationButtonState) {
        [textCongratulationButton, poetryCongratulationButton, haikuCongratulationButton].forEach {
            if $0.title != title && $0.selectedState == state && buttonType != .none {
                $0.changeSelectionState()
            }
            
            let name = buttonType == .none ? nil : title
            
            viewModel.setupGreetingsType(with: name)
            setupSentensesNumberLabel(with: buttonType)
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
        
        [titleLabel, buttonsStack, congratulationLenghLabel, lenghSlider, continueButton,
         numberOfSentensesStackView].forEach(view.setupView)
        
        [minCountOfSentensesLabel, maxCountOfSentensesLabel].forEach(numberOfSentensesStackView.addArrangedSubview)
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
            
            numberOfSentensesStackView.topAnchor.constraint(equalTo: lenghSlider.bottomAnchor, constant: 10),
            numberOfSentensesStackView.leadingAnchor.constraint(equalTo: lenghSlider.leadingAnchor),
            numberOfSentensesStackView.trailingAnchor.constraint(equalTo: lenghSlider.trailingAnchor),
            
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
        lenghSlider.addTarget(self, action: #selector(setupCurrentSentensesValue), for: .valueChanged)
    }
}
