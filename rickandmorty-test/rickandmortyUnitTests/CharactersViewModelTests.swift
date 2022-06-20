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
    var page = 1
    var selectedCharacter: ((Int) -> Void)?
    
    override func setUp() {
        super.setUp()
        mockAPIService = MockAPIService()
        sut = CharactersListViewModel(page: page, apiService: mockAPIService)
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

    func test_onAppear_event() {
        sut.send(event: .onAppear)
        XCTAssertEqual(sut.state, .loading)
    }
    
    func test_onReload_event() {
        sut.send(event: .onReload)
        XCTAssertEqual(sut.state, .loading)
    }
    
    func test_onLoadMore_event() {
    sut.send(event: .onLoadMore)
        XCTAssertEqual(sut.state, .loading)
    }
        
    func test_onSelect_event() {
        sut.send(event: .onSelect(1))
//        XCTAssert(sut.selectedCharacter )
    }
}
