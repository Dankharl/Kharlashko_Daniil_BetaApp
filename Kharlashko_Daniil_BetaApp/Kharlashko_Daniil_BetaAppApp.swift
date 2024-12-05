//
//  Kharlashko_Daniil_BetaAppApp.swift
//  Kharlashko_Daniil_BetaApp
//
//  Created by Daniil Kharlashko on 24/10/2024.
//

import SwiftUI

@main
struct Kharlashko_Daniil_BetaAppApp: App {

    @StateObject var appState = AppState() // Create AppState instance

    var body: some Scene {
        WindowGroup {
//            .environmentObject(appState) // Provide AppState to the view
            if appState.isLoggedIn {
                ContentView() // Main content view after login
//                AccountView()
                    .environmentObject(appState)
            } else {
                SignUpView() // Show login/signup page
                    .environmentObject(appState)
            }
        }
    }
}
