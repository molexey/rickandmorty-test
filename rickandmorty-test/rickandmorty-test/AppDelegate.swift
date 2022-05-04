//
//  AppDelegate.swift
//  rickandmorty-test
//
//  Created by molexey on 04.05.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let charactersViewController = CharactersViewController(nibName: nil, bundle: nil)
        let navigationController = UINavigationController(rootViewController: charactersViewController)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        window?.rootViewController = navigationController
        
        return true
    }
}
