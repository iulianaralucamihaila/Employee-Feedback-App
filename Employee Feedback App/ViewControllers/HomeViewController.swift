//
//  ViewController.swift
//  Employee Feedback App
//
//  Created by Mobile Academy on 19.06.2022.
//

import UIKit

class HomeViewController: UITableViewController {
    var users = ["Ana", "Maria", "Cosmin", "Mihai", "Andreea", "Miruna", "Anca", "Vlad"]
    
    var filtredUsers = [String]()
    
    @IBOutlet var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Employee List"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = users[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedUser = users[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

