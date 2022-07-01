//
//  CharacterDetailsViewModel.swift
//  rickandmorty-test
//
//  Created by molexey on 14.06.2022.
//

import Foundation
import Combine
import RealmSwift

final class CharacterDetailsViewModel: ObservableObject {
    @Published private(set) var state: State = .idle
        
    var characterID: Int
    
    
    init(characterID: Int) {
        self.characterID = characterID
    }
    
    func send(event: Event) {
        switch event {
        case .onAppear:
            state = .loading
            self.getCharacter(with: String(characterID))
        case .onReload:
            state = .loading
            self.getCharacter(with: String(characterID))
        }
    }
}

extension CharacterDetailsViewModel {
    enum State {
        case idle
        case loading
        case loaded(CharacterDetail)
        case error(Error)
    }
    
    enum Event {
        case onAppear
        case onReload
    }
        
    struct CharacterDetail {
        let id: Int
        let characterImageURL: URL?
        let characterName: String?
        let characterStatus: Status?
        let statusAndSpecies: String?
        let characterLocation: String?
        let characterGender: String?
        let characterEpisodes: String?
        
        enum Status: String {
            case alive = "Alive"
            case dead = "Dead"
            case unknown = "unknown"
        }
        
        init(character: Character) {
            id = character.id ?? -1
            characterImageURL = URL(string: character.image ?? " ")
            characterName = character.name ?? " "
            characterStatus = Self.Status(rawValue: character.status ?? " ") ?? .unknown
            statusAndSpecies = "\(character.status ?? "unknown") - \(character.species ?? " ")"
            characterLocation = character.location?.name ?? " "
            characterGender = character.gender ?? " "
            characterEpisodes = String(character.episodes.count ?? 0)
        }
    }
}

extension CharacterDetailsViewModel {
    private func getCharacter(with characterID: String) {
        APIService.shared.getCharacter(load: true, characterID: characterID) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let character):
                    let characterDetail = CharacterDetail(character: character)
                    self.state = .loaded(characterDetail)
                case .failure(let error):
                    print(error)
                    self.state = .error(error)
                }
            }
        }
    }
}
