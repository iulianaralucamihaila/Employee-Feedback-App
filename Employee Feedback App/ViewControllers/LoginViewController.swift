import UIKit
import SwiftKeychainWrapper

class LoginViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var signinBtn: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    let service = AuthService()
    
    func makeLogin() {
        guard let loginRequest = getLoginRequest() else {
            self.hideSpinner()
            self.displayMessage(userMessage: "One of the required fields is missing")
            return
        }
        
        service.login(loginRequest: loginRequest) { result in
            switch result {
            case .success(let loginResult):
                KeychainWrapper.standard.set(loginResult.refreshToken, forKey: "refreshToken")
                self.setAuth()
            case .failure(let error):
                self.hideSpinner()
                self.displayMessage(userMessage: "Login not successfull")
            }
        }
    }
    
    func setAuth() {
        guard let accessTokenRequest = getAccessTokenRequest() else {
            return
        }
        
        service.accessToken(accessTokenRequest: accessTokenRequest) { result in
            switch result {
            case .success(let accessTokenResult):
                KeychainWrapper.standard.set(accessTokenResult.accessToken, forKey: "accessToken")
                UserDefaults.standard.set(true, forKey: "FirstLoginApp")
                DispatchQueue.main.async {
                    self.hideSpinner()
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "TabBar")
                    let window = UIApplication.shared.windows.first
                    window?.rootViewController = nextViewController
                }
            case.failure(let error):
                self.hideSpinner()
                self.displayMessage(userMessage: "Access token retrieval not successfull")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func SignIn(_ sender: Any) {
        showSpinner()
        self.makeLogin()
    }
    
    func showSpinner() {
        self.spinner.isHidden = false
    }
    
    func hideSpinner() {
        DispatchQueue.main.async {
            self.spinner.isHidden = true
        }
    }
    
    func getLoginRequest() -> LoginRequest? {
        // Check if required fields are not empty
        guard let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty else {
            return nil
        }
        return .init(emailAddress: email, password: password)
    }
    
    func getAccessTokenRequest() -> AccessTokenRequest? {
        guard let refreshToken = KeychainWrapper.standard.string(forKey: "refreshToken") else {
            return nil
        }
        return .init(refreshToken: refreshToken)
    }
    
//    func getToken() -> AccessTokenRequest? {
//        guard let refreshToken = KeychainWrapper.standard.string(forKey: "refreshToken") else {
//            return nil
//        }
//        return .init(refreshToken: refreshToken)
//    }
    
    func displayMessage(userMessage: String) -> Void {
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
