import UIKit

class ProfileFeedbackViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Feedback List"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedbacks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Profile Feedback", for: indexPath)
        return cell
    }
    
    var feedback1 = Feedback(userName: "", averageScore: 4.3, comments: "")
    var feedback2 = Feedback(userName: "", averageScore: 5.0, comments: "")
    var feedback3 = Feedback(userName: "", averageScore: 4.1, comments: "")
    var feedback4 = Feedback(userName: "", averageScore: 3.0, comments: "")
    var feedback5 = Feedback(userName: "", averageScore: 5.7, comments: "")
    var feedback6 = Feedback(userName: "", averageScore: 4.3, comments: "")
    
    var feedbacks = [Feedback]()
    
    func createFeedbacks() {
        feedbacks = [feedback1, feedback2, feedback3, feedback4, feedback5, feedback6]
        
        for _ in 0 ..< feedbacks.count {
            var cell: ProfileFeedbackTableViewCell
            cell.userName = 
        }
    }
}
