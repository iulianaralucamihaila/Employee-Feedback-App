import UIKit

class DetailViewController: UIViewController {
    var selectedUser: Int32!
    
    @IBOutlet var viewOldFeedbacks: UIButton!
    @IBOutlet var addFeedback: UIButton!
    @IBOutlet var biography: UILabel!
    @IBOutlet var resiliance: UILabel!
    @IBOutlet var performance: UILabel!
    @IBOutlet var innovation: UILabel!
    @IBOutlet var profilePic: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//
        getUsers()
    }
    var profileService = ProfileService()
    
    func getUsers() {
        profileService.getProfileByID(id: selectedUser) { result in
            switch result {
            case .success(let profileResponse):
                DispatchQueue.main.async {
                    self.title = "\(profileResponse.firstName) \(profileResponse.lastName)"
                    self.resiliance.text = String(profileResponse.score1)
                    self.performance.text = String(profileResponse.score2)
                    self.innovation.text = String(profileResponse.score3)
                    self.biography.text = profileResponse.biography
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
