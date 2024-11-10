//
//  HomeViewModel.swift
//  RickyMortySwiftUI
//
//  Created by serhat on 9.11.2024.
//

import SwiftUI

protocol HomeViewModelProtocol {
    var characters: [Result] { get set }
    var service: NetworkServiceProtocol { get set }
    func fetchCharacters(endpoint: NetworkEndpoint) async
}

final class HomeViewModel: HomeViewModelProtocol, ObservableObject {
    @Published var searchText: String = ""
    @Published var characters: [Result] = []
    @Published var viewState: ViewState = .fetching
    @Published var filteredCharacters: [Result] = []
    @Published var characterFilter: CharacterFilter = .all
    
    let columns: [GridItem] = [.init(.flexible()), .init(.flexible())]
    var service: NetworkServiceProtocol
    var page: Int = 1
    
    init(service: NetworkServiceProtocol) {
        self.service = service
        Task { await fetchCharacters(endpoint: .characters(page: page)) }
    }
    
    
    @MainActor
    func fetchCharacters(endpoint: NetworkEndpoint) async {
        viewState = .fetching
        defer { viewState = .finished }
        do {
            let response = try await service.fetch(endpoint, type: Character.self)
            self.characters.append(contentsOf: response.results)
        } catch let error{
            print(error.localizedDescription)
        }
    }
    
    func hasReachedEnd(of character: Result) async {
        if self.characters.last?.id == character.id {
            page += 1
            await fetchCharacters(endpoint: .characters(page: page))
        }
    }
    
    func searchCharacter() {
        if !searchText.isEmpty,
           searchText.count >= 3 {
            self.characterFilter = .search
            self.filteredCharacters = characters.filter({$0.name.lowercased().trimmingCharacters(in: .whitespaces).contains(searchText.lowercased().trimmingCharacters(in: .whitespaces))})
        } else {
            self.characterFilter = .all
            self.filteredCharacters = []
        }
    
    }
    
}

extension HomeViewModel {
    
    enum ViewState {
        case fetching
        case finished
    }
    
    enum CharacterFilter {
        case all
        case search
    }
    
}
