import Foundation

protocol CongratulationTypeViewModelProtocol: AnyObject {
    var isReadyToMakeRequestObservable: Observable<Bool> { get }
    var selectedGreetingsType: String? { get }
    var selectedGreetingsLength: Int? { get }
    func setupGreetingsType(with name: String?)
    func setupGreetingsLength(with number: Int)
    func sentCongratulationType()
}
