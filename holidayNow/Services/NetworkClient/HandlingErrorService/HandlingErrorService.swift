import Foundation

final class HandlingErrorService {
    func sendErrorToAnalytics(error: Error) {
        guard let error = error as? NetworkClientError else { return }
        
        AnalyticsService.instance.trackAmplitudeEvent(name: .error, params: [.description: error.toString()])
    }
}
