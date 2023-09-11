import Foundation

protocol FirstFormViewModelProtocol: AnyObject {
    var userNameObservable: Observable<String?> { get }
    var interestsObservable: Observable<Interest> { get }
    var selectedInterestsObservable: Observable<[GreetingTarget]> { get }
    func setupUsername(_ name: String?)
    func controlInterestState(isAdd: Bool, interest: GreetingTarget)
    func addNewOwnInterest(name: String)
    func sentInterests()
}
