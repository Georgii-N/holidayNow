import Foundation

final class GreetingRequestFactory: GreetingRequestFactoryProtocol {
    
    // MARK: - Dependencies
    private var greetingRequestModel: GreetingRequest?
    
    // MARK: - Public Methods
    func createRequestText(greetingRequestModel: GreetingRequest) -> String {
        ""
    }
}
