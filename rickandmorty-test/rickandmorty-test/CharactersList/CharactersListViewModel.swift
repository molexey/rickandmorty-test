//
//  CharactersListViewModel.swift
//  rickandmorty-test
//
//  Created by molexey on 13.06.2022.
//

import Foundation
import Combine
import CollectionAndTableViewCompatible

final class CharactersListViewModel: ObservableObject {
    @Published private(set) var state = State.idle
    private var page: Int
    public var characters: [Character] = []
    private var currentInfо: Info? = nil
    var data: [TableViewCompatible] = []
    
    public var selectedCharacter: ((Int) -> Void)?
    
    private let apiCaller = APICaller.shared
    
    init(page: Int) {
        self.page = page
    }
    
    func send(event: Event) {
        switch event {
        case .onAppear:
            state = .loading
            getCharacters(with: String(page))
            
        case .onLoaded:
            state = .idle
            
        case .onLoadMore:
            state = .loading
            loadMoreCharacters()
            
        case .onSelect(let characterID):
            selectedCharacter?(characterID)
            
        case .onReload:
            state = .loading
            getCharacters(with: String(page))
        }
    }
}

extension CharactersListViewModel {
    enum State {
        case idle
        case loading
        case loaded
        case error(Error)
    }
    
    enum Event {
        case onAppear
        case onLoadMore
        case onSelect(Int)
        case onLoaded
        case onReload
    }
}

extension CharactersListViewModel {
    private func getCharacters(with param: String) {
        APICaller.shared.getCharacters(load: true, query: param) { result in
            DispatchQueue.main.async { [self] in
                switch result {
                case .success(let response):
                    self.currentInfо = response.info
                    if let characters = response.results {
                        self.characters.append(contentsOf: characters)
                        self.data.append(contentsOf: self.characters.map({CharacterCellModel(character: $0)}))
                    }
                    self.state = .loaded
                    
                case .failure(let error):
                    print(error)
                    self.state = .error(error)
                }
//                self.data = self.characters.map({CharacterCellModel(character: $0)})
            }
        }
    }
    
    private func loadMoreCharacters() {
        let hasNextPage = (currentInfо?.next != nil)
        //activityIndicator.isHidden = true
        guard hasNextPage, !self.apiCaller.isLoading else { return }
        page += 1
        getCharacters(with: String(page))
        //activityIndicator.isHidden = false
    }
}
