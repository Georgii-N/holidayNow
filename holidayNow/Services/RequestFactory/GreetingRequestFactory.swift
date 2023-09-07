import Foundation

final class GreetingRequestFactory: GreetingRequestFactoryProtocol {
    
    // MARK: - Dependencies
    private var greetingRequestModel: GreetingRequest?
    
    // MARK: - Public Methods
    func createRequestText(greetingRequestModel: GreetingRequest) -> String {
        if let interestsString = greetingRequestModel.interests {
            return "Поздравь на русском языке с праздником: \(greetingRequestModel.holiday). Имя человека: \(greetingRequestModel.name). Количество предложений: \(greetingRequestModel.countSentences). Тип поздравления: \(greetingRequestModel.type). Интересы: \(interestsString.joined(separator: ", ")). Тональность поздравления: \(greetingRequestModel.intonation ?? "обычная")"
        } else {
            return "Поздравь на русском языке с праздником: \(greetingRequestModel.holiday). Имя человека: \(greetingRequestModel.name). Количество предложений: \(greetingRequestModel.countSentences). Тип поздравления: \(greetingRequestModel.type). Тональность поздравления: \(greetingRequestModel.intonation ?? "обычная")"
        }
    }
}
