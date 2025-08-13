//
//  LoginView.swift
//  Ogonek
//
//  Created by Danila Volkov on 01.08.2025.
//

import SwiftUI

struct LoginView: View {
    @State private var viewModel = LoginViewModel()
    @FocusState private var focusedField: Field?

    enum Field: Hashable {
        case username, password
    }

    var body: some View {
        NavigationStack {
            VStack{
                headerSection

                loginForm

                loginButton

                // signUpSection TODO: add when done
            }
            .padding()
            .navigationBarHidden(true)
            .alert("Error", isPresented: .constant(!viewModel.errorMessage.isNil)) {
                Button("OK", role: .cancel) {
                    viewModel.errorMessage = nil
                }
            } message: {
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                }
            }
            .overlay {
                if viewModel.isLoading {
                    ProgressView("Signing in...")
                        .padding()
                }
            }
        }
    }

    private var headerSection: some View {
        VStack(spacing: 16) {
            Image(systemName: "flame.fill")
                .font(.system(size: 60))
                .padding(.top, 60)

            VStack(spacing: 8) {
                Text("Welcome to")
                    .font(.title2)
                    .foregroundColor(.secondary)

                Text("Ogonek")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
            }
        }
    }

    private var loginForm: some View {
        VStack {
                TextField("Username", text: $viewModel.username)
                    .focused($focusedField, equals: .username)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .submitLabel(.next)
                    .onSubmit {
                        focusedField = .password
                    }

                SecureField("Password", text: $viewModel.password)
                    .focused($focusedField, equals: .password)
                    .submitLabel(.go)
                    .onSubmit {
                        Task {
                            await viewModel.signIn()
                        }

            }
        }
        .textFieldStyle(.roundedBorder)
        .padding()
    }

    // MARK: - Login Button
    private var loginButton: some View {
        Button {
            Task {
                await viewModel.signIn()
            }
        } label: {
            HStack {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    Image(systemName: "arrow.right")
                        .font(.title3)
                        .fontWeight(.medium)
                }

                Text(viewModel.isLoading ? "Signing In..." : "Sign In")
                    .font(.headline)
                    .fontWeight(.semibold)
            }
        }
        .disabled(!viewModel.canSignIn || viewModel.isLoading)
        .animation(.easeInOut(duration: 0.2), value: viewModel.canSignIn)
    }

    // MARK: - Sign Up Section
    private var signUpSection: some View {
        HStack {
            Text("Don't have an account?")
                .font(.subheadline)
                .foregroundColor(.secondary)

            NavigationLink {
                SignUpView()
            } label: {
                Text("Sign Up")
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }
        }
        .padding()
    }
}

// MARK: - Preview
#Preview {
    LoginView()
}
