//
//  CharacterDetailsViewModelNew.swift
//  rickandmorty-test
//
//  Created by molexey on 14.06.2022.
//

import Foundation
import Combine

final class CharacterDetailsViewModelNew: ObservableObject {
    @Published private(set) var state: State = .idle
        
    func send(event: Event) {
        switch event {
        case .onAppear(let characterID):
            state = .loading
            self.getCharacter(with: String(characterID))
        case .onLoaded:
            state = .idle
        case .onReload(let characterID):
            state = .loading
            self.getCharacter(with: String(characterID))
        }
    }
}

extension CharacterDetailsViewModelNew {
    enum State {
        case idle
        case loading
        case loaded(CharacterDetail)
        case error(Error)
    }
    
    enum Event {
        case onAppear(Int)
        case onLoaded
        case onReload(Int)
        //case onFailedToLoad(Error)
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
            characterEpisodes = String(character.episode?.count ?? 0)
        }
    }
}


extension CharacterDetailsViewModelNew {
   private func getCharacter(with characterID: String) {
//        self.isLoading = true
//        state.self = .loading(characterID)
        
        APICaller.shared.getCharacter(load: true, characterID: characterID) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let character):
                    let characterDetail = CharacterDetail(character: character)
                    self!.state = .loaded(characterDetail)
                case .failure(let error):
                    print(error)
                    self!.state = .error(error)
                }
            }
        }
    }
}
