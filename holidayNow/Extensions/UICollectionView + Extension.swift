import UIKit

extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(indexPath: IndexPath, with identificator: String) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: identificator, for: indexPath) as? T else {
            assertionFailure("Could not dequeue cell with identifier: \(identificator) for: \(indexPath)")
            return T()
        }
        return cell
    }
}
