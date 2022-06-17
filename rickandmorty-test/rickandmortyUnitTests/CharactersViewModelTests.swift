//
//  CharactersViewModelTests.swift
//  rickandmorty-testUnitTests
//
//  Created by molexey on 17.06.2022.
//

import XCTest
@testable import rickandmorty

class CharactersListViewModelTests: XCTestCase {
    
    var sut: CharactersListViewModel!
    var mockAPIService: MockAPIService!
    
    override func setUp() {
        super.setUp()
        mockAPIService = MockAPIService()
        sut = CharactersListViewModel(page: 1, apiService: mockAPIService)
    }
    
    override func tearDown() {
        sut = nil
        mockAPIService = nil
        super.tearDown()
    }
    
    func test_get_characters() {
        mockAPIService.completionCharacters = [Character]()
        
        sut.getCharacters(with: "1")
        
        XCTAssert(mockAPIService!.isGetCharactersCalled)
    }


}
