import Foundation

final class DataProvider: DataProviderProtocol {
    
    // MARK: - Dependencies
    private var networkClient: NetworkClientProtocol
    private var greetingRequestFactory: GreetingRequestFactoryProtocol
    
    // MARK: - Constants and Variables
    private var type: String?
    private var countSentences: Int?
    private var name: String?
    private var holiday: String?
    private var interests: [String]?
    private var intonation: String?
    
    private var requestText: String?
    private var responseText: String?
    
    // MARK: - LifeCycle
    init(networkClient: NetworkClientProtocol, greetingRequestFactory: GreetingRequestFactoryProtocol) {
        self.networkClient = networkClient
        self.greetingRequestFactory = greetingRequestFactory
    }
    
    // MARK: - Public Methods
    func setType(type: String) {
        self.type = type
    }
    
    func setcountSentences(countSentences: Int) {
        self.countSentences = countSentences
    }
    
    func setName(name: String) {
        self.name = name
    }
    
    func setHoliday(holiday: String) {
        self.holiday = holiday
    }
    
    func setInterests(interests: [String]) {
        self.interests = interests
    }
    
    func setIntonation(intonation: String) {
        self.intonation = intonation
    }
    
    func createRequestText() {
        guard let creatingModel = createGreetingModel() else { return }
        
        requestText = greetingRequestFactory.createRequestText(greetingRequestModel: creatingModel)
        
        guard let requestText else {
            assertionFailure("requestText is nil")
            return
        }
        
        networkClient.fetchGreeting(text: requestText) { result in
            switch result {
            case .success(let responseText):
                self.responseText = responseText
            case .failure(let error):
                assertionFailure(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Private Methods
    private func isReadyForConversion() -> Bool {
        return type != nil &&
        countSentences != nil &&
        name != nil &&
        holiday != nil
    }
    
    private func createGreetingModel() -> GreetingRequest? {
        if isReadyForConversion() {
            return GreetingRequest(type: self.type ?? "",
                                   countSentences: self.countSentences ?? 1,
                                   name: self.name ?? "",
                                   holiday: self.holiday ?? "",
                                   interests: self.interests,
                                   intonation: self.intonation)
        } else {
            assertionFailure("greetingModel is invalid")
            return nil
        }
    }
}
