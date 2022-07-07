import UIKit

class HomeViewController: UITableViewController, UISearchBarDelegate {
    
    var user1 = User(emailAdress: "maria@db.com", password: "1234", firstName: "Anca", lastName: "Ionescu", resiliance: 4.5, performance: 5, innovation: 4.7, biography: "Full-stack Developper")

    var user2 = User(emailAdress: "sebastian@db.com", password: "1234", firstName: "Sebastian", lastName: "Dumitrescu", resiliance: 3.7, performance: 4, innovation: 4.2, biography: "Junior Java Developper")

    var user3 = User(emailAdress: "alexandra@db.com", password: "1234", firstName: "Alexandra", lastName: "Badea", resiliance: 5, performance: 5, innovation: 4.5, biography: "Phyton Developper")

    var user4 = User(emailAdress: "anton@db.com", password: "1234", firstName: "Anton", lastName: "Stan", resiliance: 3.8, performance: 5, innovation: 4.7, biography: "PHP Developper")

    var user5 = User(emailAdress: "cosmin@db.com", password: "1234", firstName: "Cosmin", lastName: "Andone", resiliance: 4.8, performance: 4.8, innovation: 4.1, biography: ".NET Developper")

    var user6 = User(emailAdress: "nicoleta@db.com", password: "1234", firstName: "Nicoleta", lastName: "Tudose", resiliance: 3.5, performance: 3, innovation: 3, biography: "Junior Phyton Developper")
    
    var users = [EmployeeListResponse]()
    var usersFullName = [String]()
    var filtredUsers = [String]()
    
    var employeeService = EmployeeListService()
    
    func getUsers() {
        employeeService.getEmployeeList { result in
            switch result {
            case .success(let employeeResponse):
                DispatchQueue.main.async {
                    self.users = employeeResponse
                    for i in 0 ..< employeeResponse.count {
                        self.usersFullName.append(employeeResponse[i].firstName + " " + employeeResponse[i].lastName)
                    }
                    print(employeeResponse)
                    print(employeeResponse.count)
                    print(self.usersFullName)
                    self.filtredUsers = self.usersFullName
                    self.profileTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    @IBOutlet var profileTableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Employee List"
        
        profileTableView.dataSource = self
        getUsers()
        print(self.usersFullName)
        filtredUsers = usersFullName
    }
    
    
    // Table
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
            vc.selectedUser = users[indexPath.row].apiUserId
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // Search bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filtredUsers = []
        
        if searchText == "" {
            filtredUsers = usersFullName
        }
        else {
            for user in usersFullName {
                if user.lowercased().contains(searchText.lowercased()) {
                    filtredUsers.append(user)
                }
            }
        }
        self.tableView.reloadData()
    }
}
