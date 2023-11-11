import UIKit
import StoreKit

final class SuccessViewController: UIViewController {
    
    // MARK: - Dependencies
    weak var coordinator: CoordinatorProtocol?
    private var successViewModel: SuccessViewModelProtocol
    
    // MARK: - Constants and Variables:
    private enum SuccessUIConstants {
        static let imageViewHeight: CGFloat = 220
        static let buttonInsetFromCenter: CGFloat = 10
    }
    
    // MARK: - UI:
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = Resources.Images.ResponseScreens.responseSuccess
        return imageView
    }()
    
    private lazy var responseTextView: UITextView = {
        let responseTextView = UITextView()
        responseTextView.font = .bodyMediumRegularFont
        responseTextView.textColor = .blackDay
        responseTextView.text = successViewModel.textResultObservable.wrappedValue
        responseTextView.textAlignment = .center
        responseTextView.isEditable = false
        responseTextView.isScrollEnabled = true
        return responseTextView
    }()
    
    private lazy var editButton = BaseCustomButton(buttonState: .normal, buttonText: L10n.Success.EditButton.Edit.title)
    private lazy var backToStartButton = BaseCustomButton(buttonState: .back, buttonText: L10n.Success.BackToStartButton.title)
    private lazy var shareButton = BaseCustomButton(buttonState: .normal, buttonText: L10n.Success.ShareButton.title)
    private lazy var customNavigationBar = BaseNavigationBar(title: L10n.ResultScreen.title, isBackButton: true, coordinator: coordinator)
    
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
        bind()
    }
    
    // MARK: - Private Methods:
    private func bind() {
        successViewModel.textResultObservable.bind { [weak self] _ in
            guard let self else { return }
            self.resumeOnMainThread(self.updateResultText, with: ())
        }
    }
    
    private func updateResultText() {
        self.responseTextView.text = successViewModel.textResultObservable.wrappedValue
    }
    
    // MARK: - Objc Methods:
    @objc private func didTapEditButton() {
        coordinator?.presentEditViewController(presenter: self)
    }
    
    @objc private func didTapGoToStartButton() {
        AnalyticsService.instance.trackAmplitudeEvent(name: .didTapGoToStartButton, params: nil)
        coordinator?.goToFirstFormViewController()
        coordinator?.removeAllviewControllers()
        successViewModel.resetGreeting()
    }
    
    @objc private func didTapShareButton() {
        AnalyticsService.instance.trackAmplitudeEvent(name: .didTapShareButton, params: nil)
        guard let response = responseTextView.text else { return }
        let activityViewController = UIActivityViewController(
            activityItems: [response],
            applicationActivities: nil)
        
        present(activityViewController, animated: true)
    }
}

// MARK: - Setup Views:
extension SuccessViewController: EditViewControllerDelegate {
    func updateText() {
        successViewModel.getResultText()
    }
}

// MARK: - Setup Views:
private extension SuccessViewController {
    func setupViews() {
        
        view.backgroundColor = .whiteDay
        
        customNavigationBar.setupNavigationBar(with: view, controller: self)
        
        [imageView,
         editButton,
         responseTextView,
         backToStartButton,
         shareButton].forEach(view.setupView)
    }
    
    func setupConstraints() {
        setupImageViewConstraints()
        setupResponseTextViewConstraints()
        setupEditButtonConstraints()
        setupBackToStartButtonConstraints()
        setupBackToShareButtonConstraints()
    }
    
    func setupImageViewConstraints() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: customNavigationBar.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: SuccessUIConstants.imageViewHeight)
        ])
    }
    
    func setupEditButtonConstraints() {
        NSLayoutConstraint.activate([
            editButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: UIConstants.sideInset),
            editButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.sideInset),
            editButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.sideInset)
        ])
    }
    
    func setupResponseTextViewConstraints() {
        NSLayoutConstraint.activate([
            responseTextView.topAnchor.constraint(equalTo: editButton.bottomAnchor, constant: UIConstants.blocksInset),
            responseTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.sideInset),
            responseTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.sideInset),
            responseTextView.bottomAnchor.constraint(equalTo: backToStartButton.topAnchor, constant: -UIConstants.elementsInset)
        ])
    }
    
    func setupBackToStartButtonConstraints() {
        NSLayoutConstraint.activate([
            backToStartButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -UIConstants.blocksInset),
            backToStartButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.sideInset),
            backToStartButton.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -SuccessUIConstants.buttonInsetFromCenter)
        ])
    }
    
    func setupBackToShareButtonConstraints() {
        NSLayoutConstraint.activate([
            shareButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -UIConstants.blocksInset),
            shareButton.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: SuccessUIConstants.buttonInsetFromCenter),
            shareButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.sideInset)
        ])
    }
    
    func setupTargets() {
        editButton.addTarget(self, action: #selector(didTapEditButton), for: .touchUpInside)
        backToStartButton.addTarget(self, action: #selector(didTapGoToStartButton), for: .touchUpInside)
        shareButton.addTarget(self, action: #selector(didTapShareButton), for: .touchUpInside)
    }
}
