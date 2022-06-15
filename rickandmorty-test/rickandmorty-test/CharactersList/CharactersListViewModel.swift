//
//  CharactersListViewModel.swift
//  rickandmorty-test
//
//  Created by molexey on 13.06.2022.
//

import Foundation
import Combine

final class CharactersListViewModel: ObservableObject {
    @Published private(set) var state = State.idle
    private var bag = Set<AnyCancellable>()
    private let input = PassthroughSubject<Event, Never>()
    
//    init() {
//        .assign(to: \.state, on: self)
//        .store(in: &bag)
//    }
    
    deinit {
        bag.removeAll()
    }
    
    func send(event: Event) {
        input.send(event)
    }
    
}

extension CharactersListViewModel {
    enum State {
        case idle
        case loading
        case loaded([ListItem])
        case error(Error)
    }
    
    enum Event {
        case onAppear
        case onSelectCharacters(Int)
        case onCharactersLoaded([ListItem])
        case onFailedToLoadCharacters(Error)
    }
    
    struct ListItem: Identifiable {
        let id: Int
        let name: String
        let avatar: String//URL?
        
        init(character: Character) {
            id = character.id!
            name = character.name!
            avatar = character.image!
        }
    }
}
