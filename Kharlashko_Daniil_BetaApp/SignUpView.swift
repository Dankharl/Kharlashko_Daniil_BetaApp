//
//  SignUpView.swift
//  BetaApp
//
//  Created by Daniil Kharlashko on 23/10/2024.
//

// sign-up, login logic.

import SwiftUI

struct SignUpView: View {
    

    @EnvironmentObject var appState: AppState  // Access the global login state
    @State private var isSignUp: Bool = true // Toggle between login and sign-up
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var errorMessage: String = "" // Error message for validation
    
    var body: some View {
        ZStack {
            Color(.darkGray).ignoresSafeArea() // Dark gray background

            VStack(spacing: 20) {
                Text(isSignUp ? "Sign Up" : "Login")
                    .font(.system(size: 60))
                    .foregroundColor(.white)
                    .bold()
                    .padding(.bottom, 20)

                // Username field (only for Sign Up)
                if isSignUp {
                    ZStack(alignment: .leading) {
                        if username.isEmpty {
                            Text("Username")
                                .foregroundColor(.white.opacity(0.7)) // White placeholder text
                                .padding(.leading, 10)
                        }
                        TextField("", text: $username)
                            .padding()
                            .background(Color(UIColor.systemBlue).opacity(0.2))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.blue.opacity(0.7), lineWidth: 1))
                    }
                }

                // Email field (used in both login and sign-up)
                ZStack(alignment: .leading) {
                    if email.isEmpty {
                        Text("Email")
                            .foregroundColor(.white.opacity(0.7)) // White placeholder text
                            .padding(.leading, 10)
                    }
                    TextField("", text: $email)
                        .padding()
                        .background(Color(UIColor.systemBlue).opacity(0.2))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.blue.opacity(0.7), lineWidth: 1))
                        .keyboardType(.emailAddress)
                }

                // Password field
                ZStack(alignment: .leading) {
                    if password.isEmpty {
                        Text("Password")
                            .foregroundColor(.white.opacity(0.7)) // White placeholder text
                            .padding(.leading, 10)
                    }
                    SecureField("", text: $password)
                        .padding()
                        .background(Color(UIColor.systemBlue).opacity(0.2))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.blue.opacity(0.7), lineWidth: 1))
                }

                // Confirm Password field (only for Sign Up)
                if isSignUp {
                    ZStack(alignment: .leading) {
                        if confirmPassword.isEmpty {
                            Text("Confirm Password")
                                .foregroundColor(.white.opacity(0.7)) // White placeholder text
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
                }

                // Error Message
                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding(.bottom, 10)
                }

                // Login or Sign Up Button
                Button(action: {
                    if isSignUp {
                        // Handle sign-up validation
                        signUp()
                    } else {
                        // Try to log in
                        if appState.logIn(email: email, password: password) {
                            errorMessage = "" // Clear error message on success
                        } else {
                            errorMessage = "Invalid email or password."
                        }
                    }
                }) {
                    Text(isSignUp ? "Sign Up" : "Login")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue.opacity(0.7))
                        .cornerRadius(10)
                }
                .padding(.top, 20)

                // Switch between Login and Sign Up
                Button(action: {
                    isSignUp.toggle() // Toggle between login and sign-up
                    errorMessage = "" // Clear error message when switching
                }) {
                    Text(isSignUp ? "Already have an account? Login" : "Don't have an account? Sign Up")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                }
                .padding(.top, 10)
            }
            .padding()
        }
    }

    // Sign Up Validation
    func signUp() {
        // Username must be at least 3 characters
        if username.count < 3 {
            errorMessage = "Username must be at least 3 characters long."
            return
        }

        // Validate email format
        if !isValidEmail(email) {
            errorMessage = "Please enter a valid email address."
            return
        }

        // Password must be at least 3 characters
        if password.count < 3 {
            errorMessage = "Password must be at least 3 characters long."
            return
        }

        // Password and confirm password must match
        if password != confirmPassword {
            errorMessage = "Passwords do not match."
            return
        }

        // If all validations pass, sign up the user
        errorMessage = "" // Clear the error message
        appState.signUp(username: username, email: email, password: password)
    }

    // Simple email format validation
    func isValidEmail(_ email: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: email)
    }
}
