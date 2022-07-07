//
//  AppDelegate.swift
//  Employee Feedback App
//
//  Created by Mobile Academy on 19.06.2022.
//

import UIKit
import SwiftKeychainWrapper

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow()
        let accessToken: String? = KeychainWrapper.standard.string(forKey: "accessToken")
    
        if UserDefaults.standard.bool(forKey: "FirstLoginApp"),
            accessToken != nil {
            let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let homePage = mainStoryboard.instantiateViewController(withIdentifier: "TabBar")
           window?.rootViewController = homePage
        } else {
            let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let login = mainStoryboard.instantiateViewController(withIdentifier: "InitialNavController")
            window?.rootViewController = login
        }
        window?.makeKeyAndVisible()
        return true
    }
}
