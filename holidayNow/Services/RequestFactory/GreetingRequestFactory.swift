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
        L10n.GreetingFactory.typeText + greetingRequestModel.type
    }
    
    private func createCountSentencesText() -> String {
        L10n.GreetingFactory.sentensesCountText + " \(greetingRequestModel.countSentences) "
    }
    
    private func createNameText() -> String {
        L10n.GreetingFactory.nameText + "\(greetingRequestModel.name) "
    }
    
    private func createHolidayText() -> String {
        L10n.GreetingFactory.holidayText + "\(greetingRequestModel.holiday) "
    }
    
    private func createInterestsText() -> String {
        if let interestsString = greetingRequestModel.interests {
            return L10n.GreetingFactory.interestsText + "\(interestsString.joined(separator: ", ")). "
        }
        return ""
    }
    
    private func createIntonationText() -> String {
        L10n.GreetingFactory.intonationText + "\(greetingRequestModel.intonation ?? L10n.GreetingFactory.stumbText)"
    }
}
