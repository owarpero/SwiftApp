//
//  LoginView.swift
//  MatchFilm
//
//  Created by Pasha Hurs on 19.04.25.
//
import SwiftUI
import AuthenticationServices

@main
struct MoviePickerApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                LoginView()
            }
            .preferredColorScheme(.dark)
        }
    }
}

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showError: Bool = false
    @State private var errorMessage: String = ""

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack(spacing: 20) {
                Text("Movie Picker")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                Text("Sign in to continue")
                    .foregroundColor(.gray)

                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.darkGray))
                    .cornerRadius(8)
                    .foregroundColor(.white)
                    .padding(.horizontal)

                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.darkGray))
                    .cornerRadius(8)
                    .foregroundColor(.white)
                    .padding(.horizontal)

                Button(action: loginWithEmail) {
                    Text("Log In")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding(.horizontal)
                }

                SignInWithAppleButton(
                    .signIn,
                    onRequest: { request in
                        request.requestedScopes = [.fullName, .email]
                    },
                    onCompletion: handleAppleSignIn
                )
                .signInWithAppleButtonStyle(.white)
                .frame(height: 45)
                .padding(.horizontal)

                HStack {
                    Text("Don't have an account?")
                        .foregroundColor(.gray)
                    NavigationLink(destination: RegistrationView()) {
                        Text("Sign Up")
                            .foregroundColor(.blue)
                            .bold()
                    }
                }
                .padding(.top, 10)

                if showError {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                }

                Spacer()
            }
        }
    }

    private func loginWithEmail() {
        guard !email.isEmpty, !password.isEmpty else {
            showError(message: "Please enter email and password.")
            return
        }
        // TODO: Call your API for email/password authentication
    }

    private func handleAppleSignIn(result: Result<ASAuthorization, Error>) {
        switch result {
        case .success(let auth):
            if let credential = auth.credential as? ASAuthorizationAppleIDCredential {
                let userId = credential.user
                // TODO: Send credential.identityToken to your server
                // let token = String(data: credential.identityToken ?? Data(), encoding: .utf8)
            }
        case .failure(let error):
            showError(message: error.localizedDescription)
        }
    }

    private func showError(message: String) {
        errorMessage = message
        showError = true
    }
}
