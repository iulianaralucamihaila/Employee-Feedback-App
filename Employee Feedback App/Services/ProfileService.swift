import Foundation
import SwiftKeychainWrapper

class ProfileService {
    private func getProfileRequest() -> URLRequest?{
        
        var request = URLRequest(url: URL(string: "https://efa-app.ml/api-dev/profile/personal")!)
        request.httpMethod = "GET"
        let accessToken = KeychainWrapper.standard.string(forKey: "accessToken")
        guard let accessToken = accessToken else {
            return nil
        }
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        return request
    }

    func getProfile(completionHandler: @escaping (Result<ProfileResponse, Error>) -> ()) {
        if let profileRequest = getProfileRequest() {
            let task = URLSession.shared.dataTask(with: profileRequest) { (data: Data?, response: URLResponse?, error: Error?) in
                
                guard let data = data else {
                    completionHandler(.failure(error!))
                    return
                }
                
                do {
                    let response = try JSONDecoder().decode(ProfileResponse.self, from: data)
                    completionHandler(.success(response))
                }
                catch {
                    completionHandler(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    private func getProfileByIDRequest(id: Int32) -> URLRequest?{
        var request = URLRequest(url: URL(string: "https://efa-app.ml/api-dev/profile/id/\(id)")!)
        request.httpMethod = "GET"
        let accessToken = KeychainWrapper.standard.string(forKey: "accessToken")
        guard let accessToken = accessToken else {
            return nil
        }
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        return request
    }

    func getProfileByID(id: Int32, completionHandler: @escaping (Result<ProfileResponse, Error>) -> ()) {
        if let profileRequest = getProfileByIDRequest(id: id) {
            let task = URLSession.shared.dataTask(with: profileRequest) { (data: Data?, response: URLResponse?, error: Error?) in
                
                guard let data = data else {
                    completionHandler(.failure(error!))
                    return
                }
                
                do {
                    let response = try JSONDecoder().decode(ProfileResponse.self, from: data)
                    completionHandler(.success(response))
                }
                catch {
                    completionHandler(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    
}
