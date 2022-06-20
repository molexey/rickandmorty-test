//
//  StubGenerator.swift
//  rickandmortyUnitTests
//
//  Created by molexey on 20.06.2022.
//

import Foundation
import ObjectMapper
@testable import rickandmorty

class StubGenerator {
    func stubCharactersResponse() -> CharactersResponse {
        let path = Bundle.main.path(forResource: "character", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        let jsonString = String(decoding: data, as: UTF8.self)
        let charactersResponse = CharactersResponse(JSONString: jsonString)
        
        return charactersResponse!
    }
    
    func stubCharacters() -> [Character] {
        let path = Bundle.main.path(forResource: "character", ofType: "json")!
        let data = try! Data(contentsOf: URL(fileURLWithPath: path))
        let jsonString = String(decoding: data, as: UTF8.self)
        let charactersResponse = CharactersResponse(JSONString: jsonString)
        let characters = charactersResponse?.results
        
        return characters!
    }
}
