import UIKit

// MARK: - Resuming Methods on the main thread:
extension UIViewController {
    func resumeOnMainThread<T>(_ method: @escaping ((T) -> Void), with argument: (T)) {
        DispatchQueue.main.async {
            method(argument)
        }
    }
}

// MARK: - Keyboard Settings:
extension UIViewController {
    // Preset ViewControllers:
    func setupObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardDidShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardDidHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    private func addkeyboardHider() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))

        self.view.addGestureRecognizer(gesture)
    }
    
    // Objc Methods:
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func keyboardDidShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField = UIResponder.currentFirst() as? UITextField else { return }
        
        let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let keyboardFrameInView = view.convert(keyboardFrame.cgRectValue, from: nil)
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height
        
        if textFieldBottomY > keyboardTopY {
            let newY = view.frame.origin.y - keyboardFrameInView.size.height
            
            if newY < 0 {
                view.frame.origin.y = newY
            }
        }
        
        addkeyboardHider()
    }
    
    @objc private func keyboardDidHide() {
        view.frame.origin.y = 0
        view.gestureRecognizers?.removeAll()
    }
}

// MARK: - Warning Label:
extension UIViewController {
    func controlStateWarningLabel(label: UILabel,
                                  isShow: Bool,
                                  from collection: UICollectionView? = .none,
                                  with text: String? = .none,
                                  plus number: Int? = .none) {
        if !isShow || number == 0 {
            label.removeFromSuperview()
        } else {
            guard let collection else { return }
            let countOfCell = collection.numberOfItems(inSection: 0)
            let indexPath = IndexPath(row: countOfCell - 1, section: 0)
            guard let lastCell = collection.cellForItem(at: indexPath) as? BaseCollectionViewEnterCell else { return }
            
            if isShow {
                guard let text else { return }
            
                view.setupView(label)
                
                if let number {
                    label.text = text + "\(number)/3"
                    label.textColor = .blackDay
                } else {
                    label.text = text
                    label.textColor = .universalRed
                }
                
                NSLayoutConstraint.activate([
                    label.topAnchor.constraint(equalTo: lastCell.bottomAnchor, constant: UIConstants.mediumInset),
                    label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: UIConstants.sideSize),
                    label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -UIConstants.sideSize)
                ])
            }
        }
    }
}

// MARK: - Setting Anchors:
extension UIViewController {
    private enum ExtensionsUIConstants {
        static let largeScreenHeight: ClosedRange<CGFloat> = 800...900
        static let mediumScreenHeight: ClosedRange<CGFloat> = 600...800
        
        static let largeScreenInset: CGFloat = 40
        static let mediumScreenInset: CGFloat = 50
        static let smallScreenInset: CGFloat = 20
    }
    
    func increaseHeightAnchor(from screenHeight: CGFloat, constraints: NSLayoutConstraint) {
        switch screenHeight {
        case ExtensionsUIConstants.largeScreenHeight:
            constraints.constant += ExtensionsUIConstants.largeScreenInset
        case ExtensionsUIConstants.mediumScreenHeight:
            constraints.constant += ExtensionsUIConstants.mediumScreenInset
        default:
            constraints.constant += ExtensionsUIConstants.smallScreenInset
            return
        }
    }
}
