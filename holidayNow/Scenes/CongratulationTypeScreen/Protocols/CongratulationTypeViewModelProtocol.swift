import Foundation

protocol CongratulationTypeViewModelProtocol: AnyObject {
    func setupGreetingsType(with name: String?)
    func setupGreetingsLength(with number: Int)
    func sentCongratulationType()
}
