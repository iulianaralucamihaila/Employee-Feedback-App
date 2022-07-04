import UIKit

class HomeViewController: UITableViewController, UISearchBarDelegate {
    
    let users = ["Ana", "Maria", "Cosmin", "Mihai", "Andreea", "Miruna", "Anca", "VladVladVladVladVladVlad"]
    var filtredUsers: [String]
    
    var fetchedProfiles: [String]!
    
    @IBOutlet var profileTableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Employee List"
        
        profileTableView.dataSource = self
        
        filtredUsers = users
        
      //  parseData()

    }
    
    //url
    func parseData() {
        fetchedProfiles = []

        var request = URLRequest(url: URL(string: "https://efa-app.ml/mock/profiles")!)
                request.httpMethod = "GET"
                request.allHTTPHeaderFields = ["Accept": "application/json"]
                //request.allHTTPHeaderFields = []
                //request.setValue(<#T##value: String?##String?#>, forHTTPHeaderField: <#T##String#>)



        let task = URLSession.shared.dataTask(with: request) {
                    data, response, error in
                    if let error = error {
                        print("error: \(error.localizedDescription)")
                    } else {
                        let jsonRes = try? JSONSerialization.jsonObject(with: data!, options: [])

                        for eachFetchedProfiles in self.fetchedProfiles {
                            let eachProfiles = eachFetchedProfiles as! [String : Any]
                            let title = eachProfiles["title"] as! String
                            // let body = eachProfiles["body"] as! String

                            self.fetchedProfiles.append(title)
                        }
                        DispatchQueue.main.async {
                            self.profileTableView.reloadData()
                        }
                        //self.profileTableView.reloadData()
                        //print(self.fetchedProfiles)

                        // UserDefaults.standars.addObject()
                        print(jsonRes)
                    }
                }.resume()
    }

    
    
    //table
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtredUsers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = filtredUsers[indexPath.row]
        //cell.detailTextLabel?.text = fetchedProfiles[indexPath.row].body
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

//class Profiles {
//    var title : String
//    //var body : String
//
//    init(title : String) {
//        self.title = title
//        //self.body = body
//    }
//}
