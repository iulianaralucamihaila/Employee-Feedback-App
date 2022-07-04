import UIKit
import SwiftKeychainWrapper

struct LoginRequest: Encodable {
    let email: String
    let password: String
}

struct LoginResponse: Decodable {
    let token: String
}

class LoginViewController: UIViewController {
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var signinBtn: UIButton!
    @IBOutlet var signUpButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        title = "Login"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = nil
    }
    
    @IBAction func SignIn(_ sender: Any) {
        showActivityIndicator()
        makeLoginCall()
    }
    
    func showActivityIndicator() {
        // Create activity indicator
        let myActivityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        
        // Position Activity Indicator in the center of the main view
        myActivityIndicator.center = view.center
        
        // If needed, you can prevent Acivity Indicator from hiding when stopAnimating() is called
        myActivityIndicator.hidesWhenStopped = true
        
        // Start Activity Indicator
        myActivityIndicator.startAnimating()
        
        view.addSubview(myActivityIndicator)
    }
    
    func makeLoginCall() {
        // Send HTTP Request to perform Sign in
        let task = URLSession.shared.dataTask(with: getULRRequest()) { (data: Data?, response: URLResponse?, error: Error?) in
            
            guard let data = data else {
                self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                self.displayMessage(userMessage: "not successfully")
                return
            }
            
            do {
                let response = try JSONDecoder().decode(LoginResponse.self, from: data)
                
                KeychainWrapper.standard.set(response.token, forKey: "accessToken")
                
                DispatchQueue.main.async {
                    let homePage = self.storyboard?.instantiateViewController(withIdentifier: "EmployeeList") as! HomeViewController
                    let appDelegate = UIApplication.shared.delegate
                    appDelegate?.window??.rootViewController = homePage
                }
            } catch {
                self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                self.displayMessage(userMessage: "not successfully")
                print(error)
            }
            
        }
        task.resume()
    }
    
    func getULRRequest() -> URLRequest {
        var request = URLRequest(url: URL(string: "https://efa-app.ml/mock/login")!)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = ["Content-Type": "application/json"]
        request.allHTTPHeaderFields = ["Accept": "application/json"]
        
        let jsonEncoder = JSONEncoder()
        request.httpBody = try? jsonEncoder.encode(getLoginRequest())
        
        return request
    }
    
    func getLoginRequest() -> LoginRequest? {
        // Check if required fields are not empty
        guard let email = emailField.text,
              let password = passwordField.text else {
            
            // Display alert message
            print("Email \(String(describing: emailField.text)) or password \(String(describing: passwordField.text)) is empty")
            displayMessage(userMessage: "One of the required fields is missing")
            return nil
        }
        
        return .init(email: email, password: password)
    }
    
    func displayMessage(userMessage: String) -> Void { DispatchQueue.main.async {
        
        let alertController = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default)
        { _ in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(OKAction)
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

func removeActivityIndicator(activityIndicator: UIActivityIndicatorView) {
    DispatchQueue.main.async {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
}
}
