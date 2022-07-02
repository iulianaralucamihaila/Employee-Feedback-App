import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet var profilePic: UIImageView!
    @IBOutlet var resilienceField: UITextField!
    @IBOutlet var performanceField: UITextField!
    @IBOutlet var innovationField: UITextField!
    @IBOutlet var biographyLabel: UILabel!
    @IBOutlet var editProfile: UIButton!
    @IBOutlet var viewFeedbacks: UIButton!
    @IBOutlet var logoutBtn: UITabBarItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        }
    @IBAction func signOutButtonTapped(_ sender: Any) {
    }
}
