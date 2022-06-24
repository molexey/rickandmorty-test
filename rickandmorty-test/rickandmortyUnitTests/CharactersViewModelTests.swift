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
    var mockCharactersFlowController: MockCharactersFlowController!
    var page = 1
    
    override func setUp() {
        super.setUp()
        mockAPIService = MockAPIService()
        mockCharactersFlowController = MockCharactersFlowController()
        
        sut = CharactersListViewModel(page: page, apiService: mockAPIService)
    }
    
    override func tearDown() {
        sut = nil
        mockAPIService = nil
        mockCharactersFlowController = nil
        super.tearDown()
    }
    
    func test_state_whenOnAppearEventSent() {
        sut.send(event: .onAppear)
        XCTAssertEqual(sut.state, .loading)
    }
    
    func test_state_whenOnReloadEventSent() {
        sut.send(event: .onReload)
        XCTAssertEqual(sut.state, .loading)
    }
    
    func test_state_whenOnLoadMoreEventSent() {
        sut.send(event: .onLoadMore)
        XCTAssertEqual(sut.state, .loading)
    }
    
    func test_selectedCharacterValue_whenOnSelectEventSent() {
        // GIVEN
        let characterID = 1
        var retrievedCharacterID: Int?
        
        // WHEN
        self.sut.selectedCharacter = { characterID in
            retrievedCharacterID = characterID
        }
        
        sut.send(event: .onSelect(characterID))
        
        // THEN
        XCTAssertEqual(characterID, retrievedCharacterID)
    }
    
    func test_callGetCharacters() {
        let characterID = "1"
        
        sut.callGetCharacters(with: characterID)
        XCTAssert(mockAPIService!.isGetCharactersCalled)
    }
    
    func test_startCharacterDetails_whenOnSelectEventSent() {
        // GIVEN
        let characterID = 2
        var retrievedCharacterID: Int?
        
        mockCharactersFlowController.start(viewModel: sut)
        
        // WHEN
        sut.send(event: .onSelect(characterID))

        // THEN
        XCTAssertTrue(mockCharactersFlowController.startCharacterDetailsCalled)
        
        retrievedCharacterID = mockCharactersFlowController.characterID
        
        XCTAssertEqual(characterID, retrievedCharacterID)
    }

    
    func test_loadedState_whenDataLoaded() {
        
        callGetCharactersFinished()
        
        let expectation = self.expectation(description: "")
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 0.5)
        
        XCTAssertEqual(self.sut.state, .loaded)
    }
}

extension CharactersListViewModelTests {
    private func callGetCharactersFinished() {
        let charactersResponse = StubGenerator().stubCharactersResponse()
        mockAPIService.charactersResponse = charactersResponse
        sut.callGetCharacters(with: "1")
        mockAPIService.fetchSuccess()
    }
}
