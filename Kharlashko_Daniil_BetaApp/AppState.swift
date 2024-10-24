//
//  AppState.swift
//  BetaApp
//
//  Created by Daniil Kharlashko on 23/10/2024.
//


//This file will contain the AppState class that handles the global login state.

// Notes:
//Great question! In SwiftUI, you use @EnvironmentObject to share data (in this case, AppState) across multiple views without needing to pass it down manually through each view

//1. Purpose of AppState Instance
//The AppState class manages the global state of your app, specifically whether the user is logged in or not. You need a single, shared instance of this class that all views can access to check the login status or trigger login/logout actions.

//2. Why Use .environmentObject(appState)?
//The .environmentObject() modifier is what allows you to inject AppState into the view hierarchy so that any child views can access it. When you provide AppState to a root view, all child views can reference it using @EnvironmentObject without having to pass it down manually through each view.


import Foundation

import SwiftUI

//In the AppState, we can hold the User object to store and manage user data globally across the app.

//class AppState: ObservableObject {
//    @Published var isLoggedIn: Bool {
//        didSet {
//            UserDefaults.standard.set(isLoggedIn, forKey: "isLoggedIn")
//        }
//    }
//    
//    @Published var user: User  // The user's profile information
//
//    init() {
//        self.isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
//        self.user = User()  // Initialize with empty values or load saved values
//    }
//
//    func logIn() {
//        isLoggedIn = true
//    }
//
//    func logOut() {
//        isLoggedIn = false
//        user = User()  // Clear user information on logout
//    }
//}

class AppState: ObservableObject {
    @Published var isLoggedIn: Bool = false
    
    @AppStorage("username") var storedUsername: String = ""
    @AppStorage("email") var storedEmail: String = ""
    @AppStorage("password") var storedPassword: String = ""
    
    @Published var user: User = User(username: "", email: "", password: "")
    
    func signUp(username: String, email: String, password: String) {
        print("Sign Up - Saving username: \(username), email: \(email), password: \(password)")
        
        // Store the user information persistently
        storedUsername = username
        storedEmail = email
        storedPassword = password
        
        // Set the user information
        user = User(username: username, email: email, password: password)
        
        // Log in the user
        isLoggedIn = true
    }
    
    func logIn(email: String, password: String) -> Bool {
        print("Trying to log in with email: \(email) and password: \(password)")
        print("Stored email: \(storedEmail), Stored password: \(storedPassword)")
        
        // Validate the login credentials by comparing with the stored email and password
        if email == storedEmail && password == storedPassword {
            // Successful login, set user info and log in
            print("Login successful")
            user = User(username: storedUsername, email: storedEmail, password: storedPassword)
            isLoggedIn = true
            return true
        } else {
            // Login failed
            print("Login failed")
            return false
        }
    }
    
    
    
    func logOut() {
        isLoggedIn = false
        print("Logged out")
    }
}

struct User {
    var username: String
    var email: String
    var password: String
}
