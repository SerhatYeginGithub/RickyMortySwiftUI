//
//  NetworkService_Tests.swift
//  RickyMortySwiftUITests
//
//  Created by serhat on 10.11.2024.
//


import XCTest
@testable import RickyMortySwiftUI

final class NetworkService_Tests: XCTestCase {
    
    private var mockService: MockNetworkService!

    override func setUp() {
        super.setUp()
        mockService = MockNetworkService()
    }
    
    func test_fetchCharactersSuccess() async throws {
        mockService.mockData = Character(results: [Result(id: 1, name: "rick", status: "alive", species: "unknown", type: "unknown", gender: "male", origin: .init(name: "earth", url: ""), location: .init(name: "earth", url: ""), image: "", episode: ["50","45"], url: "", created: "")])
        let characters: Character? = try await mockService.fetch(.characters(page: 1), type: Character.self)
        
        XCTAssertNotNil(characters, "It must not be nil.")
    }
    
    func test_fetchCharactersFailure() async throws {
        mockService.mockData = nil
        do {
            let _: Character? = try await mockService.fetch(.characters(page: 1), type: Character.self)
        } catch {
            XCTAssertEqual(error as? NetworkError, .invalidResponse)
        }
    }
    
    func test_fetchCharactersFailureInvalidUrl() async throws {
        mockService.shouldReturnError = true
        do {
            let _: Character? = try await mockService.fetch(.characters(page: 1), type: Character.self)
        } catch {
            XCTAssertEqual(error as? NetworkError, .invalidURL)
        }
        
    }
    
}
