import AmplitudeSwift

final class AnalyticsService {
    
    static let instance = AnalyticsService()
    
    private init () {}
    
    private let amplitude = Amplitude(configuration: Configuration(
           apiKey: Resources.API.amplitude
       ))
    
    func trackAmplitudeEvent(with name: String, params: [String: Any]?) {
        amplitude.track(eventType: name, eventProperties: params)
    }
}
