import UIKit

class HomeViewController: UITableViewController, UISearchBarDelegate {
    
    let users = ["Ana", "Maria", "Cosmin", "Mihai", "Andreea", "Miruna", "Anca", "VladVladVladVladVladVlad"]
    var filtredUsers: [String]!
    
    @IBOutlet var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Employee List"
        
        filtredUsers = users
        
        //url session
//        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
//        let session = URLSession.shared.dataTask(with: url) {
//            data, response, error in
//            if let error = error {
//                print("error: \(error.localizedDescription)")
//            } else {
//                let jsonRes = try? JSONSerialization.jsonObject(with: data!, options: [])
//                print(jsonRes)
//            }
//        }.resume()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtredUsers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = filtredUsers[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedUser = users[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // Search bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filtredUsers = []
        
        if searchText == ""{
           filtredUsers = users
        }
        else {
        for user in users {
            if user.lowercased().contains(searchText.lowercased()) {
                filtredUsers.append(user)
            }
        }
        }
        self.tableView.reloadData()
    }
}

