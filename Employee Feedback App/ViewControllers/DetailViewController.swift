import UIKit

class DetailViewController: UIViewController {
//    @IBOutlet var imageView: UIImageView!
    var selectedUser: String?
    
    @IBOutlet var viewOldFeedbacks: UIButton!
    @IBOutlet var addFeedback: UIButton!
    @IBOutlet var biography: UILabel!
    @IBOutlet var profilePic: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = selectedUser
//        navigationItem.largeTitleDisplayMode = .never

//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
//
//        if let imageToLoad = selectedImage {
//            imageView.image = UIImage(named: imageToLoad)
//        }
    }
}
