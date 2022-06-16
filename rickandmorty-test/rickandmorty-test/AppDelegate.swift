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
        
        let viewModel = CharactersListViewModel(page: 1)
        let viewController = CharactersViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        window?.rootViewController = navigationController
        
        viewModel.selectedCharacter = { [weak self] characterID in
            let viewModel = CharacterDetailsViewModel(characterID: characterID)
            let viewController = CharacterDetailsViewController(viewModel: viewModel)
            navigationController.pushViewController(viewController, animated: true)
        }
    
        return true
    }
}
