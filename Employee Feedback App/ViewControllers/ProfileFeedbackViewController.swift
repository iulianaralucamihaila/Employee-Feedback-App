import UIKit

class ProfileFeedbackViewController: UITableViewController {
    
    //@IBOutlet var spinner: UIActivityIndicatorView!
    
    
    var feedback1 = Feedback(userName: "Maria", averageScore: 4.3, comments: "Improve your punctuality")
    var feedback2 = Feedback(userName: "Florin", averageScore: 5.0, comments: "I appreciate your coordination skill")
    var feedback3 = Feedback(userName: "Mihai", averageScore: 4.1, comments: "Communicate more with team members!")
    var feedback4 = Feedback(userName: "Robert", averageScore: 3.0, comments: "I think you should have put in more effort")
    var feedback5 = Feedback(userName: "Ion", averageScore: 4.7, comments: "I like that you got involved in the project")
    var feedback6 = Feedback(userName: "Andreea", averageScore: 4.3, comments: "Improve your patience")
    
    var feedbacks = [Feedback]()
    
    func createFeedbacks() {
        feedbacks = [feedback1, feedback2, feedback3, feedback4, feedback5, feedback6]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Feedback List"
        
        createFeedbacks()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedbacks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Profile Feedback", for: indexPath) as! ProfileFeedbackTableViewCell
        let currentfFeedback = feedbacks[indexPath.row]
        cell.userName?.text = "  \(currentfFeedback.userName)  "
        cell.avarageScore?.text = String(currentfFeedback.averageScore)
        cell.commentLabel?.text = currentfFeedback.comments
        return cell
    }
}
