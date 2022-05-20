//
//  CharacterDetailsViewController.swift
//  rickandmorty-test
//
//  Created by molexey on 04.05.2022.
//

import UIKit

class CharacterDetailsViewController: UIViewController {
    
    var characterID: Int? = 0
    var character: Character?

    let characterDetailsView = CharacterDetailsView()
    var characterDetailsViewModel: CharacterDetailsView.ViewModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
        
        //fetchCharacter()
        if let characterID = characterID {
            getCharacter(with: (String(characterID)))
        }
    }
    
    private func getCharacter(with characterID: String) {
        APICaller.shared.getCharacter(load: true, characterID: characterID) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let character):
                    self.character = character
                case .failure(let error):
                    print(error)
                    self.showErrorAlert(title: "Boom!", message: error.localizedDescription)
                }
                self.configureCharacterDetailView(with: self.character!) // Force unwrapping!
                self.characterDetailsView.configure(with: self.characterDetailsViewModel!)
            }
        }
    }
    
    private func showErrorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Try again",
                                      style: .default,
                                      handler: { [self] (action) in self.getCharacter(with: String(characterID!))
        }))
        present(alert, animated: true, completion:  nil)
    }
    
    private func configureCharacterDetailView(with character: Character) {
        characterDetailsViewModel = CharacterDetailsView.ViewModel(
            characterImageURL: character.image ?? "",
            characterName: character.name  ?? "",
            characterStatus: CharacterDetailsView.Status(rawValue: character.status ?? "") ?? .unknown,
            characterSpecies: character.species  ?? "",
            characterLocation: character.location?.name  ?? "",
            characterGender: character.gender  ?? "",
            charactersEpisodesCount: character.episode?.count ?? 0
        )
    }
}

extension CharacterDetailsViewController {
    private func setup() {
        characterDetailsView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    private func layout() {
        view.addSubview(characterDetailsView)
        
        NSLayoutConstraint.activate([
            characterDetailsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterDetailsView.leadingAnchor.constraint(equalToSystemSpacingAfter: view.leadingAnchor, multiplier: 1),
            view.trailingAnchor.constraint(equalToSystemSpacingAfter: characterDetailsView.trailingAnchor, multiplier: 1),   characterDetailsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

//extension CharacterDetailsViewController {
//    private func fetchCharacter() {
//        characterDetailsViewModel = CharacterDetailsView.ViewModel(characterImageURL: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", characterName: "Rick Sanchez", characterStatus: .alive, characterSpecies: "Human", characterLocation: "Citadel of Ricks", characterGender: "Male", charactersEpisodesCount: 51)
//    }
//}
