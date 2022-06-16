//
//  CharactersFlowController.swift
//  rickandmorty-test
//
//  Created by molexey on 16.06.2022.
//

import UIKit

final class CharactersFlowController: UINavigationController {
    func start() {
        let charactersViewController = self.viewControllers.first as! CharactersViewController
        charactersViewController.viewModel.selectedCharacter = { [weak self] characterID in
            self?.startCharacterDetails(characterID: characterID)
        }
    }
    
    private func startCharacterDetails(characterID: Int) {
        let viewModel = CharacterDetailsViewModel(characterID: characterID)
        let viewController = CharacterDetailsViewController(viewModel: viewModel)
        self.pushViewController(viewController, animated: true)
    }
}
