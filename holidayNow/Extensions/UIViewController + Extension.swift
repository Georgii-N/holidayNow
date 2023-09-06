import UIKit

extension UIViewController {
    // MARK: - Resuming Methods on the main thread:
    func resumeOnMainThread<T>(_ method: @escaping ((T) -> Void), with argument: (T)) {
        DispatchQueue.main.async {
            method(argument)
        }
    }
    
    // MARK: - Keyboard Settings:
    private var scrollView: UIScrollView? {
        view.subviews.first { $0 is UIScrollView } as? UIScrollView
    }
    
    func setupObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardDidShow),
                                               name: UIResponder.keyboardDidShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardDidHide),
                                               name: UIResponder.keyboardDidHideNotification,
                                               object: nil)
    }
    
    func initializeHideKeyboard() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissMyKeyboard))
        view.addGestureRecognizer(gesture)
    }
    
    @objc private func keyboardDidShow(_ notification: Notification) {
        guard let usetInfo = notification.userInfo,
              let keyboardFrameSize = (usetInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        UIView.animate(withDuration: 0.3) {
            self.scrollView?.contentSize.height = (self.scrollView?.frame.height ?? 0) + keyboardFrameSize.height
            self.scrollView?.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrameSize.height, right: 0)
        }
    }
    
    @objc private func keyboardDidHide() {
        UIView.animate(withDuration: 0.3) {
            self.scrollView?.contentSize.height = self.view.frame.height
        }
    }
    
    @objc private func dismissMyKeyboard() {
        view.endEditing(true)
    }
}
