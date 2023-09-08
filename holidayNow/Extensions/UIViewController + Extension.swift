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
    
    
    @objc private func keyboardDidShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField = UIResponder.currentFirst() as? UITextField else { return }
        
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height
        
        if textFieldBottomY > keyboardTopY {
            let textBoxY = convertedTextFieldFrame.origin.y
            let newFrameY = (textBoxY - keyboardTopY / 2) * -1
            
            view.frame.origin.y = newFrameY
        }
    }
    
    @objc private func keyboardDidHide() {
        view.frame.origin.y = 0
    }
}
