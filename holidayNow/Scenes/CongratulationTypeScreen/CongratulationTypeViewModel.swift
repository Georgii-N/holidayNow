import Foundation

final class CongratulationTypeViewModel: CongratulationTypeViewModelProtocol {
    
    // MARK: - Dependencies:
    weak var dataProvider: DataProviderProtocol?
    
    // MARK: Constants and Variables:
    private var selectedGreetingsType: String?
    private var selectedGreetingsLength: Int?
    
    // MARK: - Lifecycle:
    init(dataProvider: DataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
    // MARK: - Public Methods:
    func setupGreetingsType(with name: String?) {
        selectedGreetingsType = name
    }
    
    func setupGreetingsLength(with number: Int) {
        selectedGreetingsLength = number
    }
    
    func sentCongratulationType() {
        guard let selectedGreetingsType,
              let selectedGreetingsLength else { return }
        dataProvider?.setType(type: selectedGreetingsType)
        dataProvider?.setcountSentences(countSentences: selectedGreetingsLength)
    }
}
