//
//  NetworkEndpoint.swift
//  RickyMortySwiftUI
//
//  Created by serhat on 9.11.2024.
//

import Foundation

enum NetworkEndpoint {
    
    private var BASE_URL: String { "https://rickandmortyapi.com/api/" }
    
    case detail(id: Int)
    case characters(page: Int)
    
    var url: String {
        switch self {
        case .detail(let id):
            return "\(BASE_URL)character/\(id)"
        case .characters(let page):
            return "\(BASE_URL)character?page=\(page)"
        }
    }
}
