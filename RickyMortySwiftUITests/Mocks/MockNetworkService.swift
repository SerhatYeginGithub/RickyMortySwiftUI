//
//  MockNetworkService.swift
//  RickyMortySwiftUITests
//
//  Created by serhat on 10.11.2024.
//

import Foundation
@testable import RickyMortySwiftUI

final class MockNetworkService: NetworkServiceProtocol {
    var mockData: Character? = Character(results: [Result(id: 1, name: "rick", status: "alive", species: "unknown", type: "unknown", gender: "male", origin: .init(name: "earth", url: ""), location: .init(name: "earth", url: ""), image: "", episode: ["50","45"], url: "", created: ""),Result(id: 2, name: "morty", status: "alive", species: "unknown", type: "unknown", gender: "male", origin: .init(name: "earth", url: ""), location: .init(name: "earth", url: ""), image: "", episode: ["50","45"], url: "", created: "")])
    
    var shouldReturnError: Bool = false
    
    func fetch<T>(_ endpoint: NetworkEndpoint, type: T.Type) async throws -> T where T : Decodable {
        
        if shouldReturnError {
            throw NetworkError.invalidURL
        }
        
        guard let mockData = mockData as? T else {
            throw NetworkError.invalidResponse
        }
        
        return mockData
    }
}
