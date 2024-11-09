//
//  NetworkService.swift
//  RickyMortySwiftUI
//
//  Created by serhat on 9.11.2024.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetch<T: Decodable>(_ endpoint: NetworkEndpoint, type: T.Type) async throws -> T
}

final class NetworkService: NetworkServiceProtocol {
    
    func fetch<T>(_ endpoint: NetworkEndpoint, type: T.Type) async throws -> T where T : Decodable {
        guard let url = URL(string: endpoint.url) else { throw NetworkError.invalidURL}
        
        let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))
        
        guard let response = response as? HTTPURLResponse,
              (200...300) ~= response.statusCode else {
            throw NetworkError.invalidResponse
        }
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return try decoder.decode(T.self, from: data)
    }

}
