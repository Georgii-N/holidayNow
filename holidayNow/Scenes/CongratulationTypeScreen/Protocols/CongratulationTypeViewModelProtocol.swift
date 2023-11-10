import Foundation

protocol CongratulationTypeViewModelProtocol: AnyObject {
    var selectedGreetingsType: String? { get }
    var selectedGreetingsLength: Int? { get }
    func setupGreetingsType(with name: String?)
    func setupGreetingsLength(with number: Int)
    func sentCongratulationType()
}
