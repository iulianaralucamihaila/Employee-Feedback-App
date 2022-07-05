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
    
    var user = User(emailAdress: "maria@db.com", password: "1234", firstName: "Maria", lastName: "Popescu", resiliance: 4.5, performance: 5, innovation: 3.7, biography: "iOS developper")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Profile"
        getUser()
    }

    func loadMemberProfile() {
    }
    
    func getUser() {
        firstNameLabel.text = user.firstName
        lastNameLabel.text = user.lastName
        resilianceLabel.text = String(user.resiliance)
        performanceLabel.text = String(user.performance)
        innovationLabel.text = String(user.innovation)
        biographyLabel.text = user.biography
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
