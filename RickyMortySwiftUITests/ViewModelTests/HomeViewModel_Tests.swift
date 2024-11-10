//
//  HomeViewModel_Tests.swift
//  RickyMortySwiftUITests
//
//  Created by serhat on 10.11.2024.
//


@testable import RickyMortySwiftUI
import XCTest

final class HomeViewModelTests: XCTestCase {
    
    private var mockService: MockNetworkService!
    private var viewModel: HomeViewModel!
    
    override func setUp() {
        super.setUp()
        mockService = MockNetworkService()
        
    }
    
    func test_fetchCharactersSuccess() async throws{
        viewModel = HomeViewModel(service: mockService)
        XCTAssertEqual(viewModel.viewState, .fetching)
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            XCTAssertEqual(self.viewModel.viewState, .finished)
            XCTAssertEqual(self.viewModel.characters.count, 2)
            XCTAssertEqual(self.mockService.mockData?.results.count, 2)
        }
    }
    
    func test_fetchCharactersFailure() async throws{
        mockService.mockData = nil
        viewModel = HomeViewModel(service: mockService)
        XCTAssertEqual(viewModel.viewState, .fetching)
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            XCTAssertEqual(self.viewModel.viewState, .finished)
            XCTAssertEqual(self.viewModel.characters.count, 0)
            XCTAssertNil(self.mockService.mockData)
            
        }
    }
    
    func test_fetchCharacterFailureReturnError() async throws {
        mockService.shouldReturnError = true
        viewModel = HomeViewModel(service: mockService)
        XCTAssertEqual(viewModel.viewState, .fetching)
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            XCTAssertEqual(self.viewModel.viewState, .finished)
            XCTAssertEqual(self.viewModel.characters.count, 0)
            XCTAssertNotNil(self.mockService.mockData)
            XCTAssertEqual(self.mockService.shouldReturnError, true)
            
        }
    }
    
    func test_searchCharacterSuccess() throws {
        viewModel = HomeViewModel(service: mockService)
        
        viewModel.searchText = "ric"
        viewModel.searchCharacter()
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            XCTAssertEqual(self.viewModel.characterFilter, .search)
            XCTAssertEqual(self.viewModel.filteredCharacters.count, 1)
            XCTAssertEqual(self.viewModel.filteredCharacters.first?.name, "ricky")
        }
        viewModel.searchText = ""
        viewModel.searchCharacter()
        
        DispatchQueue.main.asyncAfter(deadline: .now()+2) {
            XCTAssertEqual(self.viewModel.characterFilter, .all)
            XCTAssertEqual(self.viewModel.filteredCharacters.count, 0)
            XCTAssertEqual(self.viewModel.characters.count, 2)
        }
    }
    
}

