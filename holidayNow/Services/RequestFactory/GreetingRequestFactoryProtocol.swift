import Foundation

protocol GreetingRequestFactoryProtocol {
    func createRequestText(greetingRequestModel: GreetingRequest) -> String
}
