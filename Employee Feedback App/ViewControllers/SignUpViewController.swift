import UIKit

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
    
    @IBAction func SignUp(_ sender: Any) {
        
        // isFilled
        //
        //
        
        // Send HTTP Request to Register user
        var request = URLRequest(url: URL(string: "https://efa-app.ml/mock/register")!)
        request.httpMethod = "POST"
        
        request.allHTTPHeaderFields = ["Content-Type": "multipart/formdata"]
        request.allHTTPHeaderFields = ["accept": "application/json"]
        
        let registerRequest = ["data": ["emailAddress": emailField.text!,
                                        "password": passwordField.text!,
                                        "firstName": firstNameField.text!,
                                        "lastName": lastNameField.text!, "biography": biographyField.text!]]
        
        //                let jsonEncoder = JSONEncoder()
        //                request.httpBody = try? jsonEncoder.encode(registerRequest)
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: registerRequest, options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
            displayMessage(userMessage: "Something went wrong. Try again")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            //            self.removeActivityIndicator(activityIndicator: myActivityIndicator)
            guard let data = data, error == nil else {
                print("error=\(String(describing: error))")
                return
            }
            
            let httpStatus = response as? HTTPURLResponse
            print("statusCode should be 200, but is \(httpStatus!.statusCode)")
            print("response = \(String(describing: response))")
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString))")
            
        }
        
        task.resume()
        
        print("Sign Up button tapped")
        performSegue(withIdentifier: "SignUpSegue", sender: self)
        
    }
    
//    func getSignUpRequest() -> SignUpRequest? {
//        // Check if required fields are not empty
//        guard let email = emailField.text,
//              let password = passwordField.text else {
//
//            // Display alert message
//            print("Email \(String(describing: emailField.text)) or password \(String(describing: passwordField.text)) is empty")
//            displayMessage(userMessage: "One of the required fields is missing")
//            return nil
//        }
//        return .init(email: email, password: password)
//    }
    
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
