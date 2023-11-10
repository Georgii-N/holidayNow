import UIKit

final class EditViewController: UIViewController {

    // MARK: - Dependencies
    weak var coordinator: CoordinatorProtocol?
    weak var delegate: EditViewControllerDelegate?
    private var editViewModel: EditViewModelProtocol
    
    // MARK: - UI:
    private lazy var responseTextView: UITextView = {
        let responseTextView = UITextView()
        responseTextView.font = .bodyMediumRegularFont
        responseTextView.textColor = .blackDay
        responseTextView.textAlignment = .center
        responseTextView.text = editViewModel.getResultText()
        responseTextView.isEditable = true
        responseTextView.isScrollEnabled = false
        return responseTextView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private lazy var saveButton = BaseCustomButton(buttonState: .normal, buttonText: L10n.Success.SaveButton.Save.title)
    
    // MARK: - LifeCycle:
    init(coordinator: CoordinatorProtocol?, editViewModel: EditViewModelProtocol) {
        self.editViewModel = editViewModel
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
        addKeyboardObservers()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: - Private Methods:
    private func addKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Objc Methods:
    @objc private func didTapSaveButton() {
        responseTextView.resignFirstResponder()
        editViewModel.setResultTextAfterEdit(text: responseTextView.text)
        delegate?.updateText()
        self.dismiss(animated: true)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size {
            scrollView.contentInset.bottom = keyboardSize.height
        }
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        scrollView.contentInset.bottom = 0
    }

}

// MARK: - Setup Views:
private extension EditViewController {
    func setupViews() {
        view.backgroundColor = .whiteDay
        
        [saveButton, scrollView].forEach(view.setupView)
        scrollView.setupView(responseTextView)
    }
    
    func setupConstraints() {
        setupSaveButtonConstraint()
        setupScrollViewConstraint()
        setupResponseTextViewConstraint()
    }
    
    func setupTargets() {
        saveButton.addTarget(self, action: #selector(didTapSaveButton), for: .touchUpInside)
    }
    
    func setupSaveButtonConstraint() {
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: UIConstants.sideInset),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.sideInset),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.sideInset)
        ])
    }
    
    func setupScrollViewConstraint() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: UIConstants.blocksInset),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.sideInset),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.sideInset),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -UIConstants.sideInset)
        ])
    }
    
    func setupResponseTextViewConstraint() {
        NSLayoutConstraint.activate([
            responseTextView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            responseTextView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            responseTextView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            responseTextView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            responseTextView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
}
