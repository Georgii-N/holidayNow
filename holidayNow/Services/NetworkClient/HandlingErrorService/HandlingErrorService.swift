import Foundation

final class HandlingErrorService {
    func sendErrorToAnalytics(error: Error) {
        guard let error = error as? NetworkClientError else { return }
        
        switch error {
        case .httpStatusCode(let code):
            AnalyticsService.instance.trackAmplitudeEvent(with: "Error",
                                                          params: ["description": "StatusCode Error",
                                                                   "code" : code])
        case .parsingError:
            AnalyticsService.instance.trackAmplitudeEvent(with: "Error", params: ["description": "Parsing Error"])
        case .urlRequestError(let errorString):
            AnalyticsService.instance.trackAmplitudeEvent(with: "Error", params: ["description": "urlRequest Error: \(errorString.localizedDescription)"])
        case .urlSessionError:
            AnalyticsService.instance.trackAmplitudeEvent(with: "Error", params: ["description": "UrlSession Error"])
        }
    }
}
