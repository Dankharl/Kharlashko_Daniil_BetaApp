//
//  ContentView.swift
//  BetaApp
//
//  Created by Daniil Kharlashko on 23/10/2024.
//

import SwiftUI

struct ContentView: View {
    
    
    @EnvironmentObject var appState: AppState
    @State private var navigateToAccount = false // Track navigation state
    
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
                
                // Navigate to Account page button
                Button(action: {
                    navigateToAccount = true // Trigger navigation
                }) {
                    Text("Go to Account")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
            }
            .padding()
            // Navigate to AccountView when button is pressed
            .navigationDestination(isPresented: $navigateToAccount) {
                AccountView()
                    .navigationBarBackButtonHidden(true) // Hide back button on Account page
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AppState())
}
