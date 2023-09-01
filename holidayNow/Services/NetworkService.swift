import Foundation

final class NetworkService {
    
    var apiKey: String
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    func fetchGreeting(text: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: Resources.URLs.defaultURL) else {
            assertionFailure("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue(apiKey, forHTTPHeaderField: Resources.API.deepAI)
        
        let postString = "text=\(text)"
        request.httpBody = postString.data(using: .utf8)
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(Response.self, from: data)
                    if let decodedText = response.output.removingPercentEncoding {
                        completion(.success(decodedText))
                    }
                }
                catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}
