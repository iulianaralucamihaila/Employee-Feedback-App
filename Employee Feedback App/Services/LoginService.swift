import UIKit

class LoginService {
    
    func getURLRequest(loginRequest: LoginRequest) -> URLRequest {
        var request = URLRequest(url: URL(string: "https://efa-app.ml/mock/login")!)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = ["Content-Type": "application/json"]
        request.allHTTPHeaderFields = ["Accept": "application/json"]
        
        let jsonEncoder = JSONEncoder()
        request.httpBody = try? jsonEncoder.encode(loginRequest)
        return request
    }
    
    func login(loginRequest: LoginRequest, completionHandler: @escaping (Result<LoginResponse, Error>) -> ()) {
        let task = URLSession.shared.dataTask(with: getURLRequest(loginRequest: loginRequest)) { (data: Data?, response: URLResponse?, error: Error?) in
            
            guard let data = data else {
                completionHandler(.failure(error!))
                return
            }
            do {
                let response = try JSONDecoder().decode(LoginResponse.self, from: data)
                completionHandler(.success(response))
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
    
    
}
