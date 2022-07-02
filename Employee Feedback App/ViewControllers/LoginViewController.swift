import UIKit

struct LoginRequest: Encodable {
    let email: String
    let password: String
}

class LoginViewController: UIViewController {
    @IBOutlet var emailField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var signinBtn: UIButton!
    @IBOutlet var signUpButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        // Read values from text fields
        let email = emailField.text
        let password = passwordField.text
        
        // Check if required fields are not empty
        if (email?.isEmpty)! || (password?.isEmpty)! {
            
            // Display alert message
            print("Email \(String(describing: email)) or password \(String(describing: password)) is empty")
            displayMessage(userMessage: "One of the required fields is missing")
            return
        }
        
        // Create activity indicator
        let myActivityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        
        // Position Activity Indicator in the center of the main view
        myActivityIndicator.center = view.center
        
        // If needed, you can prevent Acivity Indicator from hiding when stopAnimating() is called
        myActivityIndicator.hidesWhenStopped = false
        
        // Start Activity Indicator
        myActivityIndicator.startAnimating()
        
        view.addSubview(myActivityIndicator)
        
        // Send HTTP Request to perform Sign in
        var request = URLRequest(url: URL(string: "https://efa-app.ml/mock/login")!)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = ["Content-Type": "application/json"]
        
        let loginRequest = LoginRequest(email: emailField.text!,
                                        password: passwordField.text!)
        
        let jsonEncoder = JSONEncoder()
        request.httpBody = try? jsonEncoder.encode(loginRequest)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
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
