//
//  ProfileInformationView.swift
//  BetaApp
//
//  Created by Daniil Kharlashko on 23/10/2024.
//

import SwiftUI

struct ProfileInformationView: View {

    @EnvironmentObject var appState: AppState  // Access the global user state
    @Environment(\.presentationMode) var presentationMode  // To go back to the previous screen
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""
    @State private var errorMessage: String = ""

    var body: some View {
        ZStack {
            // Dark gray background that covers the entire screen
            Color(.darkGray)
                .edgesIgnoringSafeArea(.all) // Ensures the background extends to the edges

            VStack(spacing: 20) {
                Text("Profile Information")
                    .font(.largeTitle)
                    .foregroundColor(.white)

                // Username field (editable)
                ZStack(alignment: .leading) {
                    if appState.user.username.isEmpty {
                        Text("Username")
                            .foregroundColor(.white.opacity(0.7))
                            .padding(.leading, 10)
                    }
                    TextField("", text: $appState.user.username)
                        .padding()
                        .background(Color(UIColor.systemBlue).opacity(0.2))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.blue.opacity(0.7), lineWidth: 1))
                }

                // Email field (editable)
                ZStack(alignment: .leading) {
                    if appState.user.email.isEmpty {
                        Text("Email")
                            .foregroundColor(.white.opacity(0.7))
                            .padding(.leading, 10)
                    }
                    TextField("", text: $appState.user.email)
                        .padding()
                        .background(Color(UIColor.systemBlue).opacity(0.2))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.blue.opacity(0.7), lineWidth: 1))
                        .keyboardType(.emailAddress)
                }

                // New Password field (optional)
                ZStack(alignment: .leading) {
                    if newPassword.isEmpty {
                        Text("New Password")
                            .foregroundColor(.white.opacity(0.7))
                            .padding(.leading, 10)
                    }
                    SecureField("", text: $newPassword)
                        .padding()
                        .background(Color(UIColor.systemBlue).opacity(0.2))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.blue.opacity(0.7), lineWidth: 1))
                }

                // Confirm Password field
                ZStack(alignment: .leading) {
                    if confirmPassword.isEmpty {
                        Text("Confirm Password")
                            .foregroundColor(.white.opacity(0.7))
                            .padding(.leading, 10)
                    }
                    SecureField("", text: $confirmPassword)
                        .padding()
                        .background(Color(UIColor.systemBlue).opacity(0.2))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.blue.opacity(0.7), lineWidth: 1))
                }

                // Error message
                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding(.bottom, 10)
                }

                // Save Button
                Button(action: {
                    saveProfileChanges()
                }) {
                    Text("Save Changes")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.7))
                        .cornerRadius(10)
                }
                .padding(.top, 20)
            }
            .padding()
        }
        .navigationTitle("Profile Information")
    }

    // Save profile changes and validate inputs
    func saveProfileChanges() {
        // Validate only the fields that were changed or need validation
        if appState.user.username.count < 3 {
            errorMessage = "Username must be at least 3 characters long."
            return
        }

        // Validate email format only if it was changed
        if !appState.user.email.isEmpty && !isValidEmail(appState.user.email) {
            errorMessage = "Please enter a valid email address."
            return
        }

        // If password fields are not empty, check if passwords match and meet the minimum length requirement
        if !newPassword.isEmpty || !confirmPassword.isEmpty {
            if newPassword.count < 3 {
                errorMessage = "Password must be at least 3 characters long."
                return
            }
            if newPassword != confirmPassword {
                errorMessage = "Passwords do not match."
                return
            }
            // Save new password only if both are non-empty
            appState.user.password = newPassword
        }

        // If everything is fine, clear the error message
        errorMessage = ""

        // Print updated values in the console
        print("Updated Username: \(appState.user.username)")
        print("Updated Email: \(appState.user.email)")
        if !newPassword.isEmpty {
            print("Updated Password: \(newPassword)")
        }

        // Update the stored values in AppStorage
        appState.storedUsername = appState.user.username
        appState.storedEmail = appState.user.email
        if !newPassword.isEmpty {
            appState.storedPassword = newPassword
        }

        // Dismiss the current view (go back to the previous screen)
        presentationMode.wrappedValue.dismiss()
    }

    // Simple email format validation
    func isValidEmail(_ email: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: email)
    }
}

#Preview {
    ProfileInformationView()
        .environmentObject(AppState())  // Preview with dummy app state
}
