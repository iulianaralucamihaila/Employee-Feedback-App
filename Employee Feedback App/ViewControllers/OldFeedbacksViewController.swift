import UIKit

class OldFeedbacksViewController: UITableViewController {
    let feedbacks = ["Feedback 1", "Feedback 2", "Feedback 3", "Feedback 4", "Feedback 5", "Feedback 6", "Feedback 7", "Feedback 8"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Feedback List"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return feedbacks.count
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Feedback List", for: indexPath)
            cell.textLabel?.text = feedbacks[indexPath.row]
            return cell
        }
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if let vc = storyboard?.instantiateViewController(withIdentifier: "Feedback details") as? FeedbackDetailViewController {
                vc.selectedFeedback = feedbacks[indexPath.row]
                navigationController?.pushViewController(vc, animated: true)
            }
        }

}
