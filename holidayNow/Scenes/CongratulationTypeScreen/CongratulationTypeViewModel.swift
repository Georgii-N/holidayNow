import Foundation

final class CongratulationTypeViewModel: CongratulationTypeViewModelProtocol {
    
    // MARK: - Dependencies:
    weak var dataProvider: DataProviderProtocol?
    
    // MARK: Constants and Variables:
    private(set) var selectedGreetingsType: String?
    private(set) var selectedGreetingsLength: Int?
    
    // MARK: - Observable Values:
    var isReadyToMakeRequestObservable: Observable<Bool> {
        $isReadyToMakeRequest
    }
    
    @Observable
    private var isReadyToMakeRequest = false
    
    // MARK: - Lifecycle:
    init(dataProvider: DataProviderProtocol) {
        self.dataProvider = dataProvider
        checkToExistingGreeting()
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
        isReadyToMakeRequest = true
    }
    
    // MARK: - Private Methods:
    private func checkToExistingGreeting() {
        selectedGreetingsType = dataProvider?.type
        selectedGreetingsLength = dataProvider?.countSentences
    }
}
