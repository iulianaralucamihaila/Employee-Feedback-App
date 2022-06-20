//
//  DetailViewController.swift
//  Employee Feedback App
//
//  Created by Mobile Academy on 20.06.2022.
//

import UIKit

class DetailViewController: UIViewController {
//    @IBOutlet var imageView: UIImageView!
    var selectedUser: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = selectedUser
        navigationItem.largeTitleDisplayMode = .never

//        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
//
//        if let imageToLoad = selectedImage {
//            imageView.image = UIImage(named: imageToLoad)
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.hidesBarsOnTap = false
    }
}
