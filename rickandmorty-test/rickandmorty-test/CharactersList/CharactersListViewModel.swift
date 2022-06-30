//
//  CharactersListViewModel.swift
//  rickandmorty-test
//
//  Created by molexey on 13.06.2022.
//

import Foundation
import Combine
import CollectionAndTableViewCompatible
import RealmSwift

final class CharactersListViewModel: ObservableObject {
    @Published private(set) var state = State.idle
    private var page: Int
    private var currentInfо: Info? = nil
    private let apiService: APIServiceProtocol
    public var data: [TableViewCompatible] = []
    public var selectedCharacter: ((Int) -> Void)?
    
    private let realm: Realm
    private var token: NotificationToken?
    
    init(page: Int, apiService: APIServiceProtocol = APIService.shared) {
        self.page = page
        self.apiService = apiService
        self.realm = try! Realm()
    }
    
    private func loadFromRealm() {
                
        self.data = realm.objects(Character.self)
//            .prefix(20)
            .map({CharacterCellModel(character: $0)})
        
        print("Data count \(self.data.count)")
        self.page = (self.data.count / 20) + 1
        
        self.currentInfо = realm.objects(Info.self).last
        print(self.currentInfо?.next)
        
        self.state = .loaded
    }
    
    private func observeRealm() {
        token = realm.observe({ notification, realm in
            print(notification)
            
            self.loadFromRealm()
        })
    }
        
    private func writeToRealm(this response: CharactersResponse) {
        do {
            let realm = try Realm()
            try realm.write() {
                realm.add(response.results, update: .modified)
                if let info = response.info {
                    realm.add(info)
                    self.currentInfо = info
                }
                self.state = .loaded
                print(self.state)
            }
        } catch {
            print("Unable to update existing results in Realm")
        }
    }
    
    func send(event: Event) {
        switch event {
        case .onAppear:
            state = .loading
            loadFromRealm()
            observeRealm()
            callGetCharacters(with: String(page))
            
        case .onLoadMore:
            state = .loading
            loadMoreCharacters()
            
        case .onSelect(let characterID):
            selectedCharacter?(characterID)
                        
        case .onReload:
            state = .loading
            callGetCharacters(with: String(page))
        }
    }
}

extension CharactersListViewModel {
    
    enum State: Equatable {
        static func == (lhs: CharactersListViewModel.State, rhs: CharactersListViewModel.State) -> Bool {
            switch (lhs, rhs) {
            case (.idle, .idle):
                return true
            case(.loading, .loading):
                return true
            case(.loaded, .loaded):
                return true
            case(.error, .error):
                return true
            default:
                return false
            }
        }
        
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
    public func callGetCharacters(with param: String) {
        apiService.getCharacters(load: true, query: param) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let response):
                    self?.writeToRealm(this: response)
                case .failure(let error):
                    print(error)
                    self?.state = .error(error)
                }
            }
        }
    }
        
    private func loadMoreCharacters() {
        let hasNextPage = (currentInfо?.next != nil)
        //activityIndicator.isHidden = true
        guard hasNextPage, !self.apiService.isLoading else { return }
        page += 1
        
        callGetCharacters(with: String(page))
        //activityIndicator.isHidden = false
    }
}
