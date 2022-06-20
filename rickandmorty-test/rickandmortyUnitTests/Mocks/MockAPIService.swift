//
//  MockAPIService.swift
//  rickandmorty-test
//
//  Created by molexey on 17.06.2022.
//

import Foundation
import ObjectMapper
@testable import rickandmorty

class MockAPIService: APIServiceProtocol {
    var isLoading: Bool = false
    var isGetCharactersCalled = false
    var isGetCharacterCalled = false
    
    var charactersResponse: CharactersResponse?
    var error: Error?
        
    var completionClosureCharacters: ((Result<CharactersResponse, Error>) -> Void)!
    var completionClosureCharacter: ((Result<Character, Error>) -> Void)!

    func getCharacters(load: Bool = false, query: String, completion: @escaping (Result<CharactersResponse, Error>) -> Void) {

        isGetCharactersCalled = true
        completionClosureCharacters = completion
    }
    
    func getCharacter(load: Bool, characterID: String, completion: @escaping (Result<Character, Error>) -> Void) {
        
        isGetCharacterCalled = true
        completionClosureCharacter = completion

    }

    func fetchSuccess() {
        completionClosureCharacters(.success(self.charactersResponse!))
        
    }
    
    func fetchFail(error: Error?) {
        completionClosureCharacters(.failure(error!))
    }
}
