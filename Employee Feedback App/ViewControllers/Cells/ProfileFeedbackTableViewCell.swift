import UIKit

class ProfileFeedbackTableViewCell: UITableViewCell {
    @IBOutlet var userName: UILabel!
    @IBOutlet var avarageScore: UILabel!
    @IBOutlet var commentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userName.layer.borderWidth = 1
        userName.layer.borderColor = UIColor.white.cgColor
    }
}
