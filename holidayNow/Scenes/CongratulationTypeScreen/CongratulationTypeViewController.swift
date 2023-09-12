import UIKit

final class CongratulationTypeViewController: UIViewController {
    
    // MARK: - Dependencies
    weak var coordinator: CoordinatorProtocol?
    
    private var viewModel: CongratulationTypeViewModelProtocol
    
    // MARK: - UI:
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .bodyMediumRegularFont
        label.textColor = .gray
        label.text = L10n.Congratulation.title
        
        return label
    }()
    
    private lazy var congratulationTypeLabel: UILabel = {
        let label = UILabel()
        label.font = .headerSmallBoldFont
        label.textAlignment = .left
        label.text = L10n.Congratulation.chooseType
        
        return label
    }()
    
    private lazy var buttonsStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 20
        
        return stackView
    }()
    
    private lazy var congratulationLenghLabel: UILabel = {
        let label = UILabel()
        label.font = .headerSmallBoldFont
        label.text = L10n.Congratulation.sentencesLengh
        label.textAlignment = .left
        return label
    }()
    
    private lazy var lenghSlider: UISlider = {
        let slider = UISlider()
        slider.tintColor = .universalRed
        slider.thumbTintColor = .universalRed
        slider.maximumTrackTintColor = .black
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.value = 0
        
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
        label.font = .captionSmallRegularFont
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var maxCountOfSentensesLabel: UILabel = {
        let label = UILabel()
        label.font = .captionSmallRegularFont
        label.textAlignment = .right
        
        return label
    }()
    
    private lazy var customNavigationBar = BaseNavigationBar(title: L10n.Congratulation.turn, isBackButton: true, coordinator: coordinator)
    private lazy var textCongratulationButton = BaseCongratulationTypeButton(buttonState: .text)
    private lazy var poetryCongratulationButton = BaseCongratulationTypeButton(buttonState: .poetry)
    private lazy var haikuCongratulationButton = BaseCongratulationTypeButton(buttonState: .haiku)
    private lazy var continueButton = BaseCustomButton(buttonState: .normal, buttonText: L10n.Congratulation.startMagic)
    
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
        
        startSetupType()
    }
    
    // MARK: - Private Methods:
    private func setupSentensesNumberLabel(with type: BaseCongratulationButtonState) {
        var minNumber: Int?
        var maxNumber: Int?
        var text: String?
                
        switch type {
        case .text:
            minNumber = Resources.Int.textMinSliderValue
            maxNumber = Resources.Int.maxSliderValue
            text = L10n.Congratulation.sentencesLengh
        case .poetry:
            minNumber = Resources.Int.poetryMinSliderValue
            maxNumber = Resources.Int.maxSliderValue
            text = L10n.Congratulation.numberOfRows
        case .haiku:
            minNumber = Resources.Int.poetryMinSliderValue
            maxNumber = Resources.Int.maxSliderValue
            text = L10n.Congratulation.numberOfRows
        case .none:
            minNumber = nil
            maxNumber = nil
            continueButton.block()
        }
                
        minCountOfSentensesLabel.text = minNumber == nil ? "" : String(minNumber ?? 0)
        maxCountOfSentensesLabel.text = maxNumber == nil ? "" : String(maxNumber ?? 0)
       
        UIView.animate(withDuration: 0.3) {
            self.lenghSlider.minimumValue = Float(minNumber ?? 0)
            self.lenghSlider.maximumValue = Float(maxNumber ?? 0)
            self.lenghSlider.layoutIfNeeded()
        }
        
        congratulationLenghLabel.text = text ?? ""
    }
    
    private func startSetupType() {
        minCountOfSentensesLabel.text = String(Resources.Int.textMinSliderValue)
        maxCountOfSentensesLabel.text = String(Resources.Int.maxSliderValue)
        congratulationLenghLabel.text = L10n.Congratulation.sentencesLengh
        
        textCongratulationButton.changeSelectionState()
        viewModel.setupGreetingsLength(with: Resources.Int.textMinSliderValue)
        viewModel.setupGreetingsType(with: L10n.Congratulation.Button.text)
    }
    
    // MARK: - Objc Methods:
    @objc private func startMagic() {
        viewModel.sentCongratulationType()
        coordinator?.goToWaitingViewController()
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
        customNavigationBar.setupNavigationBar(with: view, controller: self)
        
        [textCongratulationButton, poetryCongratulationButton, haikuCongratulationButton].forEach {
            buttonsStack.addArrangedSubview($0)
            $0.delegate = self
        }
        
        [titleLabel, congratulationTypeLabel, buttonsStack, congratulationLenghLabel, lenghSlider, continueButton,
         numberOfSentensesStackView].forEach(view.setupView)
        
        [minCountOfSentensesLabel, maxCountOfSentensesLabel].forEach(numberOfSentensesStackView.addArrangedSubview)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: customNavigationBar.bottomAnchor, constant: 20),
            
            congratulationTypeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            
            buttonsStack.heightAnchor.constraint(equalToConstant: 240),
            buttonsStack.topAnchor.constraint(equalTo: congratulationTypeLabel.bottomAnchor, constant: 30),
            buttonsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            buttonsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            congratulationLenghLabel.topAnchor.constraint(equalTo: buttonsStack.bottomAnchor, constant: 30),
            
            lenghSlider.heightAnchor.constraint(equalToConstant: 5),
            lenghSlider.topAnchor.constraint(equalTo: buttonsStack.bottomAnchor, constant: 80),
            
            numberOfSentensesStackView.topAnchor.constraint(equalTo: lenghSlider.bottomAnchor, constant: 20),
            numberOfSentensesStackView.leadingAnchor.constraint(equalTo: lenghSlider.leadingAnchor),
            numberOfSentensesStackView.trailingAnchor.constraint(equalTo: lenghSlider.trailingAnchor),
            
            continueButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40)
        ])
        
        [titleLabel, congratulationTypeLabel, congratulationLenghLabel, textCongratulationButton, poetryCongratulationButton, haikuCongratulationButton].forEach {
            $0.leadingAnchor.constraint(equalTo: buttonsStack.leadingAnchor, constant: 20).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        }
        
        [lenghSlider, continueButton].forEach {
            $0.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
            $0.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        }
    }
    
    func setupTargets() {
        continueButton.addTarget(self, action: #selector(startMagic), for: .touchUpInside)
        lenghSlider.addTarget(self, action: #selector(setupCurrentSentensesValue), for: .valueChanged)
    }
}
