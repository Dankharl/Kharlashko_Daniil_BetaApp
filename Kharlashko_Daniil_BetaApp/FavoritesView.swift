//
//  FavoritesView.swift
//  Kharlashko_Daniil_BetaApp
//
//  Created by Daniil Kharlashko on 24/10/2024.
//



//
//struct FavoritesView: View {
//    @EnvironmentObject var appState: AppState
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                // Header
//                Text("Favorites")
//                    .font(.largeTitle)
//                    .bold()
//                    .foregroundColor(.white)
//                    .padding()
//
//                // Display favorited events
//                if appState.favoriteEvents.isEmpty {
//                    Text("No favorites yet.")
//                        .font(.headline)
//                        .foregroundColor(.white)
//                        .padding()
//                } else {
//                    ScrollView {
//                        ForEach(appState.favoriteEvents) { event in
//                            NavigationLink(destination: DetailView(event: event)) {
//                                EventRow(event: .constant(event))  // Using constant since these are static events
//                            }
//                            .padding(.vertical, 10)
//                            .padding(.horizontal)
//                        }
//                    }
//                }
//            }
//            .background(Color(.darkGray).edgesIgnoringSafeArea(.all))
//        }
//    }
//}

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var appState: AppState
    @State private var searchQuery: String = ""  // For search functionality

    var filteredFavorites: [Event] {
        // Filter favorites based on search query
        if searchQuery.isEmpty {
            return appState.favoriteEvents
        } else {
            return appState.favoriteEvents.filter { event in
                event.title.lowercased().contains(searchQuery.lowercased())
            }
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                // Header
                Text("Favorites")
                    .font(.largeTitle)
                    .bold()
//                    .foregroundColor(.white)
                    .foregroundColor(Color("TextGray"))
                    .padding()

                // Search bar for filtering favorite events
                TextField("Type Search", text: $searchQuery)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.blue.opacity(0.7), lineWidth: 2)
                    )
                    .padding(.horizontal)

                // Display favorited events or empty state
                if filteredFavorites.isEmpty {
                    Spacer()
                    Text("No favorites yet.")
                        .font(.headline)
//                        .foregroundColor(.white)
                        .foregroundColor(Color("TextGray"))
                        .padding()
                    Spacer()
                } else {
                    ScrollView {
                        ForEach(filteredFavorites) { event in
                            NavigationLink(destination: DetailView(event: event)) {
                                EventRow(event: event)  // Pass event directly without `.constant`
                            }
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                        }
                    }
                }
            }
//            .background(Color(.darkGray).edgesIgnoringSafeArea(.all))
            .background(Color("BackgroundWhite").edgesIgnoringSafeArea(.all))
        }
    }
}

#Preview {
    FavoritesView()
        .environmentObject(AppState())
}
