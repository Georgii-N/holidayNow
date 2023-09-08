import Foundation

final class CongratulationTypeViewModel: CongratulationTypeViewModelProtocol {
    
    // MARK: Constants and Variables:
    private var selectedGreetingsType: String?
    private var selectedGreetingsLength: Int?
    
    // MARK: - Public Methods:
    func setupGreetingsType(with name: String?) {
        selectedGreetingsType = name
    }
    
    func setupGreetingsLength(with number: Int) {
        selectedGreetingsLength = number
    }
}
