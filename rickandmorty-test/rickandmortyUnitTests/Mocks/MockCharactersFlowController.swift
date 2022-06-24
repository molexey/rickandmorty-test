//
//  MockCharactersFlowController.swift
//  rickandmortyUnitTests
//
//  Created by molexey on 21.06.2022.
//

import UIKit
@testable import rickandmorty

class MockCharactersFlowController: CharactersFlow {
    
    var startCharacterDetailsCalled: Bool = false
    var characterID: Int?
    
    func start(viewModel: CharactersListViewModel?) {
        viewModel?.selectedCharacter = { [weak self] characterID in
            self?.startCharacterDetails(characterID: characterID)
        }
    }
        
    internal func startCharacterDetails(characterID: Int) {
        startCharacterDetailsCalled = true
        self.characterID = characterID
    }
}
