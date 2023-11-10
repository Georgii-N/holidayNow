import Foundation

final class DataProvider: DataProviderProtocol {
    
    // MARK: - Dependencies:
    private var networkClient: NetworkClientProtocol
    private var greetingRequestFactory: GreetingRequestFactoryProtocol?
    
    // MARK: - Constants and Variables:
    private var type: String?
    private var countSentences: Int?
    private var name: String?
    private var holiday: String?
    private var interests: [String]?
    private var intonation: String?
    
    private var requestText: String?
    private var responseText: String?
    
    // MARK: - LifeCycle:
    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }
    
    // MARK: - Public Methods:
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
    
    func setResultTextAfterEdit(resultText: String) {
        self.responseText = resultText
    }
    
    func createRequestText(completion: @escaping (Result<String, Error>) -> Void) {
        guard let creatingModel = createGreetingModel() else { return }
        self.greetingRequestFactory = GreetingRequestFactory(greetingRequestModel: creatingModel)
        requestText = greetingRequestFactory?.createRequestText()
        
        guard let requestText else {
            print("requestText is nil")
            return
        }
        
        networkClient.fetchGreeting(text: requestText) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let responseText):
                self.responseText = responseText
                completion(.success(responseText))
            case .failure(let error):
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }
    }
    
    func getResultText() -> String {
        guard let responseText else {
            print("responseText does not exist in dataProvider")
            return "Something went wrong...Please try later."}
        
        return responseText
    }
    
    // MARK: - Private Methods:
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
            print("greetingModel is invalid")
            return nil
        }
    }
}
