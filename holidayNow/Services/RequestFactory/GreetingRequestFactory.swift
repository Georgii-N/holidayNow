import Foundation

final class GreetingRequestFactory: GreetingRequestFactoryProtocol {
    
    // MARK: - Dependencies:
    private var greetingRequestModel: GreetingRequest
    
    init(greetingRequestModel: GreetingRequest) {
        self.greetingRequestModel = greetingRequestModel
    }
    
    // MARK: - Public Methods:
    func createRequestText() -> String {
        let name = createNameText()
        let holiday = createHolidayText()
        let type = createTypeText()
        let countSentences = createCountSentencesText()
        let interests = createInterestsText()
        let intonation = createIntonationText()
        
        let result = name + holiday + type + countSentences + interests + intonation

        return result
    }
    
    // MARK: - Private Methods:
    private func createTypeText() -> String {
        "Тип поздравления: \(greetingRequestModel.type). "
    }
    
    private func createCountSentencesText() -> String {
        "Количество предложений: \(greetingRequestModel.countSentences). "
    }
    
    private func createNameText() -> String {
        "Поздравь на русском языке человека с именем: \(greetingRequestModel.name) "
    }
    
    private func createHolidayText() -> String {
        "с праздником: \(greetingRequestModel.holiday) "
    }
    
    private func createInterestsText() -> String {
        if let interestsString = greetingRequestModel.interests {
            return "Сделай акцент на интересах человека: \(interestsString.joined(separator: ", ")). "
        }
        return ""
    }
    
    private func createIntonationText() -> String {
        "Поздравление должно быть: \(greetingRequestModel.intonation ?? "обычная")"
    }
}
