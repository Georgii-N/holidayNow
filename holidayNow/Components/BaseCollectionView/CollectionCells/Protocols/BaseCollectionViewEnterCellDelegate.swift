import Foundation

protocol BaseCollectionViewEnterCellDelegate: AnyObject {
    func addNewTarget(name: String)
    func changeStateWarningLabel(isShow: Bool)
}
