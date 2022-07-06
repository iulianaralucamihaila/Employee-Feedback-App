import UIKit

class SignUpService {
    func getURLRequest(signUpRequest: SignUpRequest) -> URLRequest {
        var request = URLRequest(url: URL(string: "https://efa-app.ml/mock/register")!)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = ["Content-Type": "multipart/formdata"]
        request.allHTTPHeaderFields = ["accept": "application/json"]
        
        let jsonEncoder = JSONEncoder()
        request.httpBody = try? jsonEncoder.encode(signUpRequest)
        return request
    }
    
    func signUp(signUpRequest: SignUpRequest, completionHandler: @escaping (Result<SignUpResponse, Error>) -> ()) {
        let task = URLSession.shared.dataTask(with: getURLRequest(signUpRequest: signUpRequest)) { (data: Data?, response: URLResponse?, error: Error?) in
            
            guard let data = data else {
                completionHandler(.failure(error!))
                return
            }
            do {
                let response = try JSONDecoder().decode(SignUpResponse.self, from: data)
                completionHandler(.success(response))
            }
            catch {
                print(error)
            }
        }
        task.resume()
}
}
