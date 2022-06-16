//
//  AppFlowController.swift
//  rickandmorty-test
//
//  Created by molexey on 16.06.2022.
//

import UIKit

final class AppFlowController: UIViewController {
    
    public func start() {
        startCharacters()
    }
    
    private func startCharacters() {
        let viewModel = CharactersListViewModel(page: 1)
        let viewController = CharactersViewController(viewModel: viewModel)
        let charactersFlowController = CharactersFlowController(rootViewController: viewController)
        
        add(childController: charactersFlowController)
        charactersFlowController.start()
    }
}
