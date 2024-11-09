//
//  MainTabView.swift
//  RickyMortySwiftUI
//
//  Created by serhat on 9.11.2024.
//

import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: TabIndex = .home
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView(service: NetworkService())
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                .tag(TabIndex.home)
            
            Text("Downloads")
                .tabItem {
                    Image(systemName: "arrow.down.circle.fill")
                    Text("Downloads")
                }
                .tag(TabIndex.downloads)
        }
        .accentColor(Color(.label))
    }
}

#Preview {
    MainTabView()
}


private extension MainTabView {
    enum TabIndex {
        case home
        case downloads
    }
}
