import Foundation

protocol FirstFormViewModelProtocol: AnyObject {
    var indexToRemoveCell: Int? { get }
    var userNameObservable: Observable<String?> { get }
    var ownCellCounterObservable: Observable<Int> { get }
    var interestsObservable: Observable<Interest> { get }
    func setupUsername(_ name: String?)
    func controlInterestState(isAdd: Bool, interest: GreetingTarget)
    func addNewOwnInterest(name: String)
    func removeOwnInterest(from index: Int)
    func sentInterests()
}
