import Foundation

enum NetworkClientError: Error {
    case httpStatusCode(Int)
    case urlRequestError(Error)
    case urlSessionError
    case parsingError
    
    func toString() -> String {
            switch self {
            case .httpStatusCode(let statusCode):
                return "HTTP Status Code: \(statusCode)"
            case .urlRequestError(let error):
                return "URL Request Error: \(error.localizedDescription)"
            case .urlSessionError:
                return "URL Session Error"
            case .parsingError:
                return "Parsing Error"
            }
        }
}

final class NetworkClient: NetworkClientProtocol {
    
    // MARK: - Constants and Variables:
    private var apiKey: String
 
    // MARK: - LifeCycle:
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    // MARK: - Public Methods
    func fetchGreeting(text: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: Resources.URLs.defaultURL) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.timeoutInterval = 10
        request.addValue(apiKey, forHTTPHeaderField: "api-key")
        
        let postString = "text=\(text)"
        request.httpBody = postString.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(NetworkClientError.urlSessionError))
                return
            }

            guard 200 ..< 300 ~= response.statusCode else {
                completion(.failure(NetworkClientError.httpStatusCode(response.statusCode)))
                return
            }
            
            if let error = error {
                completion(.failure(NetworkClientError.urlRequestError(error)))
                return
            }

            if let data = data {
                do {
                    let response = try JSONDecoder().decode(Response.self, from: data)
                    if let decodedText = response.output.removingPercentEncoding {
                        completion(.success(decodedText))
                    }
                } catch {
                    completion(.failure(NetworkClientError.parsingError))
                }
            }
        }
        task.resume()
    }
}
