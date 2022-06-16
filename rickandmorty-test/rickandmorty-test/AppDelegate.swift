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
        let appFlowController = AppFlowController()
//        let viewModel = CharactersListViewModel(page: 1)
//        let viewController = CharactersViewController(viewModel: viewModel)
//        let navigationController = UINavigationController(rootViewController: viewController)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        window?.rootViewController = appFlowController
        appFlowController.start()
    
        return true
    }
}
