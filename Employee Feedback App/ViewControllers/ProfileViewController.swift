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
    
    var profileService = ProfileService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Profile"
        getUser()
    }
    
    func setLabels(profileResponse: ProfileResponse) {
        firstNameLabel.text = profileResponse.firstName
        lastNameLabel.text = profileResponse.lastName
        resilianceLabel.text = "4.5" //String(profileResponse.score1)
        performanceLabel.text = "4.7" // String(profileResponse.score2)
        innovationLabel.text = "5" // String(profileResponse.score3)
        biographyLabel.text = profileResponse.biography
    }
    
    func getUser() {
        profileService.getProfile { result in
            switch result {
            case .success(let profileResponse):
                DispatchQueue.main.async {
                    self.setLabels(profileResponse: profileResponse)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func signOutButtonTapped(_ sender: Any) {
        
        KeychainWrapper.standard.removeObject(forKey: "accessToken")
        KeychainWrapper.standard.removeObject(forKey: "refreshToken")
        
        let signInPage = self.storyboard?.instantiateViewController(withIdentifier: "Login") as! LoginViewController
        let appDelegate = UIApplication.shared.delegate
        appDelegate?.window??.rootViewController = signInPage
    }
}
