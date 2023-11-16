import AmplitudeSwift

enum AnalyticsEvents {
    enum Name: String {
        case goToCongratulationType
        case goToFirstFormScreen
        case goToSecondFormScreen
        case goToSuccessScreen
        case goToErrorScreen
        
        case error
        
        case holiday
        case intonation
        case addNewInterest
        
        case choosenPoetry
        case choosenText
        
        case didTapGoToStartButton
        case didTapShareButton
    }
    
    enum ParamKeys: String {
        case description
        case name
    }
}

final class AnalyticsService {
    
    // MARK: - Constants and Variables:
    static let instance = AnalyticsService()
    
    private let amplitude = Amplitude(configuration: Configuration(
        apiKey: Resources.API.amplitude
    ))
    
    // MARK: - Lifecycle:
    private init () {}
    
    // MARK: - Public Methods:
    func trackAmplitudeEvent(name: AnalyticsEvents.Name, params: [AnalyticsEvents.ParamKeys: String]?) {
        var eventProperties: [String: Any]?
        if let params = params {
                eventProperties = [:]
                
                for (key, value) in params {
                    eventProperties?[key.rawValue] = value
                }
            }
        amplitude.track(eventType: name.rawValue, eventProperties: eventProperties)
    }
}
