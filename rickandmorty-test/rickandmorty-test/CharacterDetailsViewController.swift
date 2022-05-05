//
//  CharacterDetailsViewController.swift
//  rickandmorty-test
//
//  Created by molexey on 04.05.2022.
//

import UIKit

class CharacterDetailsViewController: UIViewController {

    let characterDetailsView = CharacterDetailsView()
    var characterDetailsViewModel: CharacterDetailsView.ViewModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        layout()
        
        fetchCharacter()
        characterDetailsView.configure(with: characterDetailsViewModel!)
    }
}

extension CharacterDetailsViewController {
    private func style() {
        characterDetailsView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func layout() {
        view.addSubview(characterDetailsView)
        
        NSLayoutConstraint.activate([
            characterDetailsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterDetailsView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: characterDetailsView.trailingAnchor, multiplier: 1),   characterDetailsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
//            characterDetailsView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
//            characterDetailsView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
//            view.trailingAnchor.constraint(equalToSystemSpacingAfter: characterDetailsView.trailingAnchor, multiplier: 1)
            
        ])
    }
}

extension CharacterDetailsViewController {
    private func fetchCharacter() {
        characterDetailsViewModel = CharacterDetailsView.ViewModel(characterImageURL: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", characterName: "Rick Sanchez", characterStatus: .alive, characterSpecies: "Human", characterLocation: "Citadel of Ricks", characterGender: "Male")
    }
}
