import Foundation

protocol BaseCollectionViewEnterCellDelegate: AnyObject {
    func addNewTarget(name: String)
    func changeStateCellWarningLabel(isShow: Bool, isWrongText: Bool)
}
