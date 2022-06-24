//
//  CharactersFlowController.swift
//  rickandmorty-test
//
//  Created by molexey on 16.06.2022.
//

import UIKit

protocol CharactersFlow {
    func startCharacterDetails(characterID: Int)
}

final class CharactersFlowController: UINavigationController {
    func start() {
        let charactersViewController = self.viewControllers.first as! CharactersViewController
        charactersViewController.viewModel.selectedCharacter = { [weak self] characterID in
            self?.startCharacterDetails(characterID: characterID)
        }
    }
}

extension CharactersFlowController: CharactersFlow {
    internal func startCharacterDetails(characterID: Int) {
        let viewModel = CharacterDetailsViewModel(characterID: characterID)
        let viewController = CharacterDetailsViewController(viewModel: viewModel)
        self.pushViewController(viewController, animated: true)
    }
}
