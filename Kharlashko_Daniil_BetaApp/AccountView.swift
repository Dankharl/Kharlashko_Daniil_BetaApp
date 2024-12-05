//
//  AccountView.swift
//  BetaApp
//
//  Created by Daniil Kharlashko on 23/10/2024.
//

import SwiftUI

struct AccountView: View {
    
    @EnvironmentObject var appState: AppState  // Access the global login state
//    @State private var username: String = "John Doe"  // Replace this with the actual username of the user
    
    
    var body: some View {
            NavigationView {
                VStack {
                    // Top bar with Username and Logout button
                    HStack {
                        // Use appState.user.username
                        Text(appState.user.username)
                            .font(.largeTitle)
                            .bold()
//                            .foregroundColor(.white)
                            .foregroundColor(Color("TextGray"))
                        
                        Spacer()

                        Button(action: {
                            appState.logOut()  // Log out and go back to SignUpView
                        }) {
                            Text("Log Out")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.red.opacity(0.8))
                                .cornerRadius(10)
                                .shadow(radius: 5) // Add shadow to make it stand out
                        }
                    }
                    .padding()
                    .background(Color(.darkGray))

                    Divider()
                        .background(Color.white)

                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            
                            // Profile Information Section
                            NavigationLink(destination: ProfileInformationView()) {
                                SectionView(title: "Profile Information", description: "View and edit your profile details.")
                            }
                            
                            // Notification Settings Section
                            NavigationLink(destination: NotificationSettingsView()) {
                                SectionView(title: "Notification Settings", description: "Customize your notification preferences.")
                            }

                            // Event Preferences Section
                            NavigationLink(destination: EventPreferencesView()) {
                                SectionView(title: "Event Preferences", description: "Manage your event preferences.")
                            }

                            // History of Reviews and Q&A Posted
                            NavigationLink(destination: HistoryView()) {
                                SectionView(title: "History of Reviews and Q&A", description: "View your reviews and Q&A history.")
                            }
                        }
                        .padding(.horizontal)
                    }
                }
//                .background(Color(.darkGray).ignoresSafeArea()) // Dark gray background
                .background(Color("BackgroundWhite").ignoresSafeArea())
//                .navigationTitle("Account")
            }
    }
}

// Reusable SectionView for each section with clear visual separation
struct SectionView: View {
    var title: String
    var description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.title2)
                .bold()
                .foregroundColor(.white)
            
            Text(description)
                .foregroundColor(.white.opacity(0.7))
            
            Divider()
                .background(Color.white.opacity(0.5)) // More subtle divider
        }
        .padding()
        .background(Color(UIColor.systemBlue).opacity(0.2)) // Light blue background for each section
        .cornerRadius(10)
        .shadow(radius: 5) // Shadow for visual separation
    }
}


//#Preview {
//    AccountView()
//}
