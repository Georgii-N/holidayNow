import Foundation

protocol BaseCollectionViewCellDelegate: AnyObject {
    func changeInterestState(isAdded: Bool, model: GreetingTarget)
}
