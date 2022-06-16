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
    private var currentInfо: Info? = nil
    private let apiCaller = APICaller.shared
    public var data: [TableViewCompatible] = []
    public var selectedCharacter: ((Int) -> Void)?
    
    init(page: Int) {
        self.page = page
    }
    
    func send(event: Event) {
        switch event {
        case .onAppear:
            state = .loading
            getCharacters(with: String(page))

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
        case onReload
    }
}

extension CharactersListViewModel {
    private func getCharacters(with param: String) {
        APICaller.shared.getCharacters(load: true, query: param) { result in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                switch result {
                case .success(let response):
                    self.currentInfо = response.info
                    if let characters = response.results {
                        self.data.append(contentsOf: characters.map({CharacterCellModel(character: $0)}))
                    }
                    print(self.data.count)
                    self.state = .loaded
                    
                case .failure(let error):
                    print(error)
                    self.state = .error(error)
                }
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
