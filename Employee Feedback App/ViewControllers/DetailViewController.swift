import UIKit

class DetailViewController: UIViewController {
    var selectedUser: User!
    
    @IBOutlet var viewOldFeedbacks: UIButton!
    @IBOutlet var addFeedback: UIButton!
    @IBOutlet var biography: UILabel!
    @IBOutlet var resiliance: UILabel!
    @IBOutlet var performance: UILabel!
    @IBOutlet var innovation: UILabel!
    @IBOutlet var profilePic: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\(selectedUser.firstName) \(selectedUser.lastName)"
        getUser()
    }
    
    func getUser() {
        resiliance.text = String(selectedUser.resiliance)
        performance.text = String(selectedUser.performance)
        innovation.text = String(selectedUser.innovation)
        biography.text = selectedUser.biography
    }
}
