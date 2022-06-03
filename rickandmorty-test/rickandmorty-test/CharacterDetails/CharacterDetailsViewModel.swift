//
//  CharacterDetailsViewModel.swift
//  rickandmorty-test
//
//  Created by molexey on 31.05.2022.
//

import Foundation

class CharacterDetailsViewModel {
    
    var character: Character?
    
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    var alertMessage: String? {
        didSet {
            self.showAlertClosure?()
        }
    }
    
    var showAlertClosure: (() -> Void)?
    var updateLoadingStatus: (() -> Void)?
            
    enum Status: String {
        case alive = "Alive"
        case dead = "Dead"
        case unknown = "unknown"
    }

    
    @Published var characterImageURL: URL? = nil
    @Published var characterName = " "
    @Published var characterStatus: Status = .unknown
    @Published var statusAndSpecies = " "
    @Published var characterLocation = " "
    @Published var characterGender = " "
    @Published var characterEpisodes = " "

    func getCharacter(with characterID: String) {
        self.isLoading = true
        APICaller.shared.getCharacter(load: true, characterID: characterID) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let character):
                    self?.character = character
                case .failure(let error):
                    print(error)
                    self?.alertMessage = error.localizedDescription
                }
                guard let character = self?.character else {
                    return
                }
                self?.configure(with: character)
            }
        }
    }
    
    private func configure(with: Character) {
        guard let character = character else {
            return
        }
        self.characterImageURL = URL(string: character.image ?? " ")
        self.characterName = character.name ?? " "
        self.characterStatus = CharacterDetailsViewModel.Status(rawValue: character.status ?? " ") ?? .unknown
        self.statusAndSpecies = "\(character.status ?? "unknown") - \(character.species ?? " ")"
        self.characterLocation = character.location?.name ?? " "
        self.characterGender = character.gender ?? " "
        self.characterEpisodes = String(character.episode?.count ?? 0)
    }
}
