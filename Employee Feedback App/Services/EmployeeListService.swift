import Foundation
import SwiftKeychainWrapper

class EmployeeListService {
    private func getEmployeeListRequest() -> URLRequest?{
        
        var request = URLRequest(url: URL(string: "https://efa-app.ml/api-dev/profiles/removecurrent")!)
        request.httpMethod = "GET"
        let accessToken = KeychainWrapper.standard.string(forKey: "accessToken")
        guard let accessToken = accessToken else {
            return nil
        }
        request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        return request
    }

    func getEmployeeList(completionHandler: @escaping (Result<[EmployeeListResponse], Error>) -> ()) {
        if let profileRequest = getEmployeeListRequest() {
            let task = URLSession.shared.dataTask(with: profileRequest) { (data: Data?, response: URLResponse?, error: Error?) in
                
                guard let data = data else {
                    completionHandler(.failure(error!))
                    return
                }
                
                do {
                    let response = try JSONDecoder().decode([EmployeeListResponse].self, from: data)
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
