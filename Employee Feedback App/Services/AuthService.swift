import UIKit

class AuthService {
    var accessToken: String?
    
    func getAccessTokenRequest(accessTokenRequest: AccessTokenRequest) -> URLRequest{
        var request = URLRequest(url: URL(string: "https://efa-app.ml/api-dev/auth/accesstoken")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonEncoder = JSONEncoder()
        request.httpBody = try? jsonEncoder.encode(accessTokenRequest)
        return request
    }
    
    func getURLRequest(loginRequest: LoginRequest) -> URLRequest {
        var request = URLRequest(url: URL(string: "https://efa-app.ml/api-dev/login")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonEncoder = JSONEncoder()
        request.httpBody = try? jsonEncoder.encode(loginRequest)
        return request
    }
    
    func getRegisterRequest(registerRequest: RegisterRequest) -> URLRequest {
        var request = URLRequest(url: URL(string: "https://efa-app.ml/api-dev/register")!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonEncoder = JSONEncoder()
        request.httpBody = try? jsonEncoder.encode(registerRequest)
        return request
    }
    
    func register(registerRequest: RegisterRequest, completionHandler: @escaping (Result<LoginResponse, Error>) -> ()) {
        let task = URLSession.shared.dataTask(with: getRegisterRequest(registerRequest: registerRequest)) { (data: Data?, response: URLResponse?, error: Error?) in
            
            guard let data = data else {
                completionHandler(.failure(error!))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(LoginResponse.self, from: data)
                completionHandler(.success(response))
            }
            catch {
                completionHandler(.failure(error))
            }
        }
        task.resume()
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
                completionHandler(.failure(error))
            }
        }
        task.resume()
    }
    
    func accessToken(accessTokenRequest: AccessTokenRequest, completionHandler: @escaping (Result<AccessTokenResponse, Error>) -> ()) {
        let task = URLSession.shared.dataTask(with: getAccessTokenRequest(accessTokenRequest: accessTokenRequest)) { (data: Data?, response: URLResponse?, error: Error?) in
            
            guard let data = data else {
                completionHandler(.failure(error!))
                return
            }
            do {
                let response = try JSONDecoder().decode(AccessTokenResponse.self, from: data)
                completionHandler(.success(response))
            }
            catch {
                completionHandler(.failure(error))
            }
        }
        task.resume()
    }
}
