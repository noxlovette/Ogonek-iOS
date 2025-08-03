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
            VStack(spacing: 24) {
                // Header
                headerSection

                // Login Form
                loginForm

                // Login Button
                loginButton

                // Sign Up Navigation
                signUpSection

                Spacer()
            }
            .padding(.horizontal, 20)
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
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()

                    ProgressView("Signing in...")
                        .padding()
                        .background(Color(.systemBackground))
                        .cornerRadius(10)
                }
            }
        }
    }

    // MARK: - Header Section

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

    // MARK: - Login Form

    private var loginForm: some View {
        VStack(spacing: 16) {
            // Username Field
            VStack(alignment: .leading, spacing: 8) {
                Text("Username")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)

                TextField("Enter your username", text: $viewModel.username)
                    .textFieldStyle(CustomTextFieldStyle())
                    .focused($focusedField, equals: .username)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .submitLabel(.next)
                    .onSubmit {
                        focusedField = .password
                    }
            }

            // Password Field
            VStack(alignment: .leading, spacing: 8) {
                Text("Password")
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)

                SecureField("Enter your password", text: $viewModel.password)
                    .textFieldStyle(CustomTextFieldStyle())
                    .focused($focusedField, equals: .password)
                    .submitLabel(.go)
                    .onSubmit {
                        Task {
                            await viewModel.signIn()
                        }
                    }
            }
        }
        .padding(.top, 20)
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
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .scaleEffect(0.8)
                } else {
                    Image(systemName: "arrow.right")
                        .font(.title3)
                        .fontWeight(.medium)
                }

                Text(viewModel.isLoading ? "Signing In..." : "Sign In")
                    .font(.headline)
                    .fontWeight(.semibold)
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .cornerRadius(12)
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
                // Navigate to sign up view
                SignUpView()
            } label: {
                Text("Sign Up")
                    .font(.subheadline)
                    .fontWeight(.semibold)
            }
        }
        .padding(.top, 16)
    }
}

// MARK: - Custom Text Field Style

struct CustomTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1),
            )
    }
}

// MARK: - Preview

#Preview {
    LoginView()
}
