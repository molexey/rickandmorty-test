//
//  CharacterDetailsViewModel.swift
//  rickandmorty-test
//
//  Created by molexey on 31.05.2022.
//

import Foundation

class CharacterDetailsViewModel {
    
    var character: Character?
            
    enum Status: String {
        case alive = "Alive"
        case dead = "Dead"
        case unknown = "unknown"
    }
    
    let characterImageURL: Box<URL?> = Box(nil)
    let characterName = Box(" ")
    let characterStatus: Box<Status> = Box(.unknown)
    let statusAndSpecies = Box(" ")
    let characterLocation = Box(" ")
    let characterGender = Box(" ")
    let characterEpisodes = Box(" ")

    func getCharacter(with characterID: String) {
        APICaller.shared.getCharacter(load: true, characterID: characterID) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let character):
                    self.character = character
                case .failure(let error):
                    print(error)
//                     self.showErrorAlert(title: "Boom!", message: error.localizedDescription)
                }
                guard let character = self.character else {
                    return
                }
                self.configure(with: character)
            }
        }
    }
    
    private func configure(with: Character) {
        guard let character = character else {
            return
        }
        self.characterImageURL.value = URL(string: character.image ?? " ")
        self.characterName.value = character.name ?? " "
        self.characterStatus.value = CharacterDetailsViewModel.Status(rawValue: character.status ?? " ") ?? .unknown
        self.statusAndSpecies.value = "\(character.status ?? "unknown") - \(character.species ?? " ")"
        self.characterLocation.value = character.location?.name ?? " "
        self.characterGender.value = character.gender ?? " "
        self.characterEpisodes.value = String(character.episode?.count ?? 0)
    }
}
