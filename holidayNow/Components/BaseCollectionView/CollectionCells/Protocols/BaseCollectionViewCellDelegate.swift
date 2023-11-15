import UIKit

protocol BaseCollectionViewCellDelegate: AnyObject {
    func changeTargetState(isAdded: Bool, cell: BaseCollectionViewCell)
    func startEditingNonDefaultButtons()
}
