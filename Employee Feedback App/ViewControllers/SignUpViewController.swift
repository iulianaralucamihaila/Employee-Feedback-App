import UIKit

struct RegisterRequest: Encodable {
    let emailAddress: String
    let password: String
    let firstName: String
    let lastName: String
}

class SignUpViewController: UIViewController {
    
    @IBOutlet var firstNameField: UITextField!
    @IBOutlet var lastNameField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var repeatPassword: UITextField!
    
    @IBOutlet var signupBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func SignIn(_ sender: Any) {
        
        // Validate required fields are not empty
//        if (firstNameField.text?.isEmpty)! ||
//            (lastNameField.text?.isEmpty)! ||
//            (emailField.text?.isEmpty)! ||
//            (passwordField.text?.isEmpty)! ||
//            (repeatPassword.text?.isEmpty)! {
//
//            // Display alert message and return
//            displayMessage(userMessage: "All fields are required to fill in")
//            return
//        }
//
//        // Validate password
//        if ((passwordField.text?.elementsEqual(repeatPassword.text!))! != true) {
//
//            // Display alert message and return
//            displayMessage(userMessage: "Please make sure that passwords match")
//            return
//        }
//
//        // Create activity indicator
//        let myActivityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
//
//        // Position Activity Indicator in the center of the main view
//        myActivityIndicator.center = view.center
//
//        // If needed, you can prevent Acivity Indicator from hiding when stopAnimating() is called
//        myActivityIndicator.hidesWhenStopped = false
//
//        // Start Activity Indicator
//        myActivityIndicator.startAnimating()
//
//        view.addSubview(myActivityIndicator)
//
        // Send HTTP Request to Register user
        var request = URLRequest(url: URL(string: "https://efa-app.ml/mock/register")!)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = ["Content-Type": "application/json"]
        
        let registerRequest = RegisterRequest(emailAddress: emailField.text!,
                                              password: passwordField.text!,
                                              firstName: firstNameField.text!,
                                              lastName: lastNameField.text!)
        
        let jsonEncoder = JSONEncoder()
        request.httpBody = try? jsonEncoder.encode(registerRequest)
//        do {
//            request.httpBody = try JSONSerialization.data(withJSONObject: registerRequest, options: .prettyPrinted)
//        } catch let error {
//            print(error.localizedDescription)
//            displayMessage(userMessage: "Something went wrong. Try again")
//            return
//        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
//            self.removeActivityIndicator(activityIndicator: myActivityIndicator)
            guard let data = data, error == nil else {
                print("error=\(error)")
                return
            }
            
            let httpStatus = response as? HTTPURLResponse
            print("statusCode should be 200, but is \(httpStatus!.statusCode)")
            print("response = \(response)")
            //                        print(postString)
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
            
        }
        task.resume()
        
        performSegue(withIdentifier: "SignUpSegue", sender: self)
        
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
    
    func removeActivityIndicator(activityIndicator: UIActivityIndicatorView) {
        DispatchQueue.main.async {
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }
}
