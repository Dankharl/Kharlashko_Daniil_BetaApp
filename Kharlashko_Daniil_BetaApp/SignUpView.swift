//
//  SignUpView.swift
//  BetaApp
//
//  Created by Daniil Kharlashko on 23/10/2024.
//

// sign-up, login logic.
//
//  SignUpView.swift
//  BetaApp
//
//  Created by Daniil Kharlashko on 23/10/2024.
//

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
//            Color(.darkGray).ignoresSafeArea() // Dark gray background
            Color("BackgroundWhite").ignoresSafeArea()

            VStack(spacing: 20) {
                // Title
                Text(isSignUp ? "Sign Up" : "Login")
                    .font(.system(size: 50))
//                    .foregroundColor(.white)
                    .foregroundColor(Color("TextGray"))
                    .bold()
                    .padding(.bottom, 20)

                // Username field (only for Sign Up)
                if isSignUp {
                    CustomTextField(
                        placeholder: "Username",
                        text: $username,
                        keyboardType: .default // Allow generic input for usernames
                    )
                }

                // Email field
                CustomTextField(
                    placeholder: "Email",
                    text: $email,
                    keyboardType: .emailAddress // Keep optimized for emails
                )

                // Password field
                CustomSecureField(
                    placeholder: "Password",
                    text: $password
                )

                // Confirm Password field (only for Sign Up)
                if isSignUp {
                    CustomSecureField(
                        placeholder: "Confirm Password",
                        text: $confirmPassword
                    )
                }

                // Error Message
                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding(.bottom, 10)
                }

                // Submit Button
                Button(action: {
                    if isSignUp {
                        signUp()
                    } else {
                        if appState.logIn(email: email, password: password) {
                            errorMessage = ""
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
                        .background(
                            LinearGradient(
                                colors: [Color.blue, Color.purple],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                }
                .padding(.top, 20)

                // Toggle Between Login and Sign Up
                Button(action: {
                    isSignUp.toggle()
                    errorMessage = "" // Clear error message when switching
                }) {
                    Text(isSignUp
                         ? "Already have an account? Login"
                         : "Don't have an account? Sign Up")
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
        if username.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty {
            errorMessage = "All fields are required."
            return
        }

        if username.count < 3 {
            errorMessage = "Username must be at least 3 characters long."
            return
        }

        if !isValidEmail(email) {
            errorMessage = "Please enter a valid email address."
            return
        }

        if password.count < 3 {
            errorMessage = "Password must be at least 3 characters long."
            return
        }

        if password != confirmPassword {
            errorMessage = "Passwords do not match."
            return
        }

        errorMessage = "" // Clear the error message
        appState.signUp(username: username, email: email, password: password)
    }

    // Validate Email Format
    func isValidEmail(_ email: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: email)
    }
}

struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default

    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeholder)
//                    .foregroundColor(.white.opacity(0.7))
                    .foregroundColor(Color("TextGray").opacity(0.7))
                    .padding(.leading, 10)
            }
            TextField("", text: $text)
                .keyboardType(keyboardType)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .padding()
                .background(Color(UIColor.systemBlue).opacity(0.2))
                .cornerRadius(10)
//                .foregroundColor(.white)
                .foregroundColor(Color("TextGray"))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.blue.opacity(0.7), lineWidth: 1)
                )
        }
    }
}

struct CustomSecureField: View {
    var placeholder: String
    @Binding var text: String

    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeholder)
//                    .foregroundColor(.white.opacity(0.7))
                    .foregroundColor(Color("TextGray").opacity(0.7))
                    .padding(.leading, 10)
            }
            SecureField("", text: $text)
                .textContentType(.none)
                .autocapitalization(.none)
                .padding()
                .background(Color(UIColor.systemBlue).opacity(0.2))
                .cornerRadius(10)
//                .foregroundColor(.white)
                .foregroundColor(Color("TextGray"))
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.blue.opacity(0.7), lineWidth: 1)
                )
        }
    }
}

#Preview {
    SignUpView()
        .environmentObject(AppState())
}
