//
//  NetworkError.swift
//  RickyMortySwiftUI
//
//  Created by serhat on 9.11.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case unableToData
    case decodingError
}
