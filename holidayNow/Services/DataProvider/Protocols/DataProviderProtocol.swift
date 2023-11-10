import Foundation

protocol DataProviderProtocol: AnyObject {
    var holiday: String? { get }
    var intonation: String? { get }

    func setType(type: String)
    func setcountSentences(countSentences: Int)
    func setName(name: String)
    func setHoliday(holiday: String)
    func setInterests(interests: [String])
    func setIntonation(intonation: String)
    
    func createRequestText(completion: @escaping (Result<String, Error>) -> Void)
    
    func setResultTextAfterEdit(resultText: String)
    func getResultText() -> String
    func resetGreeting()
}
