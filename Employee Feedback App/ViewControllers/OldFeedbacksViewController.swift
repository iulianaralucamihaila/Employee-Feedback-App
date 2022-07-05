import UIKit

class OldFeedbacksViewController: UITableViewController {
    
    var feedback1 = Feedback(userName: "Maria", averageScore: 4.3, comments: "Improve your patience")
    var feedback2 = Feedback(userName: "Maria", averageScore: 5.0, comments: "I like that you got involved in the project")
    var feedback3 = Feedback(userName: "Maria", averageScore: 2.5, comments: "Communicate more with team members!")
    var feedback4 = Feedback(userName: "Maria", averageScore: 3.0, comments: "I think you should have put in more effort")
    var feedback5 = Feedback(userName: "Maria", averageScore: 4.7, comments: "I appreciate your coordination skill")
    var feedback6 = Feedback(userName: "Maria", averageScore: 4.3, comments: "Improve your punctuality")
    
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "Feedback List", for: indexPath) as! EmployeeFeedbackTableViewCell
            let currentfFeedback = feedbacks[indexPath.row]
            cell.averageScore?.text = String(currentfFeedback.averageScore)
            cell.commentLabel?.text = currentfFeedback.comments
            return cell
        }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("aici")
    }
}
