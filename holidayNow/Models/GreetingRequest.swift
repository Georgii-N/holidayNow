import Foundation

struct GreetingRequest {
    let type: String
    let countSentences: Int
    let name: String
    let holiday: String
    let interests: [String]?
    let intonation: String?
}
