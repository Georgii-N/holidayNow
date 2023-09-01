import UIKit

extension UIViewController {
    func setupViews(_ view: UIView) {
        self.view.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
    }
}
