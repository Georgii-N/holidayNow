import Foundation

protocol NetworkClientProtocol {
    func fetchGreeting(text: String, completion: @escaping (Result<String, Error>) -> Void)
}
