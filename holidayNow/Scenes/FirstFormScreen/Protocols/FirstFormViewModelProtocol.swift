import Foundation

protocol FirstFormViewModelProtocol: AnyObject {
    var userNameObservable: Observable<String?> { get }
    var interestsObservable: Observable<[Interests]> { get }
    func controlInterestState(isAdd: Bool, interest: GreetingTarget)
    func setupUsername(_ name: String?)
}
