//
//  ContentView.swift
//  Kharlashko_Daniil_BetaApp
//
//  Created by Daniil Kharlashko on 24/10/2024.
//

import SwiftUI


struct ContentView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        TabView {
            // Search Page
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }

            // Map Page
            MapView(events: appState.events)  // Pass events from AppState
                .tabItem {
                    Label("Map", systemImage: "map")
                }

            // Favorites Page
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }

            // Account Page
            AccountView()
                .tabItem {
                    Label("Account", systemImage: "person")
                }
        }
        .accentColor(.blue)  // Tab color
    }
}


#Preview {
    ContentView()
        .environmentObject(AppState())
}


