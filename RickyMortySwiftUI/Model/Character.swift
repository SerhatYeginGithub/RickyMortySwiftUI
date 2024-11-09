//
//  Character.swift
//  RickyMortySwiftUI
//
//  Created by serhat on 9.11.2024.
//

import Foundation

// MARK: - Character
struct Character: Codable {
    let results: [Result]
}

// MARK: - Info
struct Info: Codable {
    let count, pages: Int
    let next: String
}

// MARK: - Result
struct Result: Codable,Identifiable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin, location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}


// MARK: - Location
struct Location: Codable {
    let name: String
    let url: String
}


