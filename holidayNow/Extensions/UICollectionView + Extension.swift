import UIKit

extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(indexPath: IndexPath, with Identificator: String) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: Identificator, for: indexPath) as? T else {
            assertionFailure("Could not dequeue cell with identifier: \(Identificator) for: \(indexPath)")
            return T()
        }
        return cell
    }
}
