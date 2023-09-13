import AmplitudeSwift

final class AnalyticsService {
    
    // MARK: - Constants and Variables:
    static let instance = AnalyticsService()
    
    private let amplitude = Amplitude(configuration: Configuration(
           apiKey: Resources.API.amplitude
       ))
    
    // MARK: - Lifecycle:
    private init () {}
    
    // MARK: - Public Methods:
    func trackAmplitudeEvent(with name: String, params: [String: Any]?) {
        amplitude.track(eventType: name, eventProperties: params)
    }
}
