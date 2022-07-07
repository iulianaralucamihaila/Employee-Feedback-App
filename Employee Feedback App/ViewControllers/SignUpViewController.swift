import UIKit
import SwiftKeychainWrapper

struct SignUpRequest: Encodable {
    let emailAddress: String
    let password: String
    let firstName: String
    let lastName: String
    let biography: String
}

struct SignUpResponse: Decodable {
    let token: String
}

class SignUpViewController: UIViewController {
    
    @IBOutlet var firstNameField: UITextField!
    @IBOutlet var lastNameField: UITextField!
    @IBOutlet var biographyField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var repeatPassword: UITextField!
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    @IBOutlet var signupBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showSpinner() {
        self.spinner.isHidden = false
    }
    
    func hideSpinner() {
        DispatchQueue.main.async {
            self.spinner.isHidden = true
        }
    }
    
    func isFilled() {
        if (firstNameField.text?.isEmpty)! ||
            (lastNameField.text?.isEmpty)! ||
            (emailField.text?.isEmpty)! ||
            (passwordField.text?.isEmpty)! ||
            (repeatPassword.text?.isEmpty)! {
            
            // Display alert message and return
            displayMessage(userMessage: "All fields are required to fill in")
            return
        }
        
        // Validate password
        if ((passwordField.text?.elementsEqual(repeatPassword.text!))! != true) {
            
            // Display alert message and return
            displayMessage(userMessage: "Please make sure that passwords match")
            return
        }
    }
    
    let service = AuthService()
    
    func makeRegister() {
        guard let registerRequest = getRegisterRequest() else {
            self.hideSpinner()
            self.displayMessage(userMessage: "One of the required fields is missing")
            return
        }
        
        service.register(registerRequest: registerRequest) { result in
            switch result {
            case .success(let loginResult):
                KeychainWrapper.standard.set(loginResult.refreshToken, forKey: "refreshToken")
                self.setAuth()
            case .failure(let error):
                self.hideSpinner()
                self.displayMessage(userMessage: "Register not successfull")
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
    
    @IBAction func SignUp(_ sender: Any) {
        makeRegister()
    }
    
    func getRegisterRequest() -> RegisterRequest? {
        // Check if required fields are not empty
        guard let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty,
              let biography = biographyField.text, !biography.isEmpty,
              let firstName = firstNameField.text, !firstName.isEmpty,
              let lastName = lastNameField.text, !lastName.isEmpty,
              let repeatPasswordString = repeatPassword.text, !repeatPasswordString.isEmpty && repeatPasswordString == password
        else {
            return nil
        }
        return .init(biography: biography, emailAddress: email, firstName: firstName, lastName: lastName, password: password)
    }
    
    func getAccessTokenRequest() -> AccessTokenRequest? {
        guard let refreshToken = KeychainWrapper.standard.string(forKey: "refreshToken") else {
            return nil
        }
        return .init(refreshToken: refreshToken)
    }
    
    
    func displayMessage(userMessage: String) -> Void { DispatchQueue.main.async {
        
        let alertController = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default)
        {(action: UIAlertAction!) in
            DispatchQueue.main.async {
                self.dismiss(animated: true, completion: nil)
            }
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
        
    }
    
}
