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
import MapKit


//In the AppState, we can hold the User object to store and manage user data globally acr\oss the app.


class AppState: ObservableObject {
    @Published var isLoggedIn: Bool = false
    
    @AppStorage("username") var storedUsername: String = ""
    @AppStorage("email") var storedEmail: String = ""
    @AppStorage("password") var storedPassword: String = ""
    
    @Published var user: User = User(username: "", email: "", password: "")
    @Published var favoriteEvents: [Event] = []  // List to store favorite events
    
    // Add your events array here
//    @Published var events: [Event] = [
//        Event(id: 1,
//              title: "Pixar Putt Returns to Discovery Green",
//              location: "Discovery Green\n1500 McKinney Street\nHouston, TX 77010",
//              time: "Varying times",
//              date: "October 13, 2024 – January 20, 2025",
//              description: "18 fun and interactive holes inspired by Disney and Pixar's films, including Toy Story, Cars, Monsters, Inc., Soul, and more!",
//              imageName: "HoustonGolf",
//              isFavorited: false,
//              rating: 4,
//              coordinate: CLLocationCoordinate2D(latitude: 29.7544, longitude: -95.3700)),
//        Event(id: 2, title: "50th Annual Texas Renaissance Festival", location: "Texas Renaissance Festival\n21778 F.M. 1774\nPlantersville, TX 77363", time: "Varying times", date: "October 12, 2024 - December 1, 2024", description: "Immerse yourself in a 16th-century European village, featuring live entertainment, food, crafts, and themed weekends like Pirate Adventure and Celtic Christmas!", imageName: "HoustonRena", isFavorited: false, rating: 5, coordinate: CLLocationCoordinate2D(latitude: 30.2333, longitude: -95.9075)),
//        Event(id: 3, title: "The Addams Family Movie Night", location: "Miller Outdoor Theatre\n6000 Hermann Park Drive\nHouston, TX 77030", time: "7:30 PM", date: "October 25, 2024", description: "Get creepy and cooky with a showing of the 1991 Addams Family film. Bring blankets and chairs or reserve free tickets.", imageName: "HoustonMovie", isFavorited: false, rating: 3, coordinate: CLLocationCoordinate2D(latitude: 29.7216, longitude: -95.3898)),
//        Event(id: 4, title: "Wings Over Houston Airshow", location: "11602 Aerospace Ave\nHouston, TX 77034", time: "8:00 AM - 4:00 PM", date: "October 26-27, 2024", description: "Enjoy aerial performances headlined by the U.S. Navy Blue Angels, vintage aviation displays, interactive areas, and meet military legends.", imageName: "HoustonFlight", isFavorited: false, rating: 5, coordinate: CLLocationCoordinate2D(latitude: 29.6073, longitude: -95.1587))
//    ]
    @Published var events: [Event] = [
        Event(
            id: 1,
            title: "Pixar Putt Returns to Discovery Green",
            location: "Discovery Green\n1500 McKinney Street\nHouston, TX 77010",
            time: "Varying times",
            date: "October 13, 2024",
            description: "18 fun and interactive holes inspired by Disney and Pixar's films, including Toy Story, Cars, Monsters, Inc., Soul, and more!",
            imageName: "HoustonGolf",
            isFavorited: false,
            rating: 4,
            coordinate: CLLocationCoordinate2D(latitude: 29.7544, longitude: -95.3700),
            category: "Entertainment"
        ),
        Event(
            id: 2,
            title: "50th Annual Texas Renaissance Festival",
            location: "Texas Renaissance Festival\n21778 F.M. 1774\nPlantersville, TX 77363",
            time: "Varying times",
            date: "October 12, 2024",
            description: "Immerse yourself in a 16th-century European village, featuring live entertainment, food, crafts, and themed weekends like Pirate Adventure and Celtic Christmas!",
            imageName: "HoustonRena",
            isFavorited: false,
            rating: 5,
            coordinate: CLLocationCoordinate2D(latitude: 30.2333, longitude: -95.9075),
            category: "Festival"
        ),
        Event(
            id: 3,
            title: "The Addams Family Movie Night",
            location: "Miller Outdoor Theatre\n6000 Hermann Park Drive\nHouston, TX 77030",
            time: "7:30 PM",
            date: "October 25, 2024",
            description: "Get creepy and cooky with a showing of the 1991 Addams Family film. Bring blankets and chairs or reserve free tickets.",
            imageName: "HoustonMovie",
            isFavorited: false,
            rating: 3,
            coordinate: CLLocationCoordinate2D(latitude: 29.7216, longitude: -95.3898),
            category: "Movies"
        ),
        Event(
            id: 4,
            title: "Wings Over Houston Airshow",
            location: "11602 Aerospace Ave\nHouston, TX 77034",
            time: "8:00 AM - 4:00 PM",
            date: "October 26, 2024",
            description: "Enjoy aerial performances headlined by the U.S. Navy Blue Angels, vintage aviation displays, interactive areas, and meet military legends.",
            imageName: "HoustonFlight",
            isFavorited: false,
            rating: 5,
            coordinate: CLLocationCoordinate2D(latitude: 29.6073, longitude: -95.1587),
            category: "Airshow"
        )
    ]
    
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

    // MARK: - Favorites Management

    func toggleFavorite(event: Event) {
        // Add or remove the event from the favorites list
        if let index = favoriteEvents.firstIndex(where: { $0.id == event.id }) {
            favoriteEvents.remove(at: index)  // Remove from favorites
        } else {
            favoriteEvents.append(event)  // Add to favorites
        }
    }
    
    func isFavorited(event: Event) -> Bool {
        return favoriteEvents.contains(where: { $0.id == event.id })
    }
}

struct User {
    var username: String
    var email: String
    var password: String
}


// Event model (keeping this here for completeness)
struct Event: Identifiable {
    let id: Int
    let title: String
    let location: String
    let time: String
    let date: String
    let description: String
    let imageName: String
    var isFavorited: Bool
    var rating: Int
    let coordinate: CLLocationCoordinate2D
    let category: String

    var dateObject: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy"
        return formatter.date(from: date)
    }
}

