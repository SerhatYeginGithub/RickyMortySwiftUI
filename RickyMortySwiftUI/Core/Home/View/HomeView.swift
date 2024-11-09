//
//  HomeView.swift
//  RickyMortySwiftUI
//
//  Created by serhat on 9.11.2024.
//

import SwiftUI



struct HomeView: View {
    
    @StateObject private var vm: HomeViewModel
    
    init(service: NetworkServiceProtocol) {
        _vm = StateObject(wrappedValue: HomeViewModel(service: service))
    }
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: vm.columns) {
                    ForEach(vm.characterFilter == .all ? vm.characters : vm.filteredCharacters) { character in
                        NavigationLink(destination: Text("Detail...")) {
                            
                            CharacterItemView(image: character.image, name: character.name)
                                .padding(.bottom)
                                .task {
                                    await vm.hasReachedEnd(of: character)
                                }
                            
                            
                        }
                    }
                }
                .padding()
            }
           
            .overlay(alignment: .center, content: {
                if vm.viewState == .fetching {
                    ProgressView()
                }
            })
            .navigationTitle("Characters")
            .searchable(text: $vm.searchText, prompt: "Search a character...")
            .onChange(of: vm.searchText) { newValue in
                if !newValue.isEmpty,
                   newValue.count >= 3 {
                    vm.searchCharacter()
                } else {
                    vm.characterFilter = .all
                }
            }
        }
    }
}

#Preview {
    HomeView(service: NetworkService())
}
