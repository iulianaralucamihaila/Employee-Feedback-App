import UIKit
import SwiftKeychainWrapper

class ProfileViewController: UIViewController {
    
    @IBOutlet var profilePic: UIImageView!
    @IBOutlet var firstNameLabel: UILabel!
    @IBOutlet var lastNameLabel: UILabel!
    @IBOutlet var resilianceLabel: UILabel!
    @IBOutlet var performanceLabel: UILabel!
    @IBOutlet var innovationLabel: UILabel!
    @IBOutlet var biographyLabel: UILabel!
    @IBOutlet var editProfile: UIButton!
    @IBOutlet var viewFeedbacks: UIButton!
    @IBOutlet var logoutBtn: UITabBarItem!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        title = "Profile"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = nil
    }
    
    func loadMemberProfile() {
        let accesToken: String? = KeychainWrapper.standard.string(forKey: "accessToken")
        let userId: String? = KeychainWrapper.standard.string(forKey: "userId")
    }
    
    @IBAction func signOutButtonTapped(_ sender: Any) {
        print("Log out button tapped.")
        KeychainWrapper.standard.removeObject(forKey: "accessToken")
        
        let signInPage = self.storyboard?.instantiateViewController(withIdentifier: "Login") as! LoginViewController
        let appDelegate = UIApplication.shared.delegate
        appDelegate?.window??.rootViewController = signInPage
        //performSegue(withIdentifier: "SignOutSegue", sender: self)
        
    }
}
