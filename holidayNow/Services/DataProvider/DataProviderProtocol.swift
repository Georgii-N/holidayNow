import Foundation

protocol DataProviderProtocol {
    func setType(type: String)
    func setcountSentences(countSentences: Int)
    func setName(name: String)
    func setHoliday(holiday: String)
    func setInterests(interests: [String])
    func setIntonation(intonation: String)
    
    func createRequestText()
}