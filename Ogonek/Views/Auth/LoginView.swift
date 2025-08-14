//
//  LoginView.swift
//  Ogonek
//
//  Created by Danila Volkov on 01.08.2025.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @FocusState private var focusedField: Field?

    enum Field: Hashable {
        case username, password
    }

    var body: some View {
        NavigationStack {
            VStack {
                headerSection
                loginForm
                loginButton
                // signUpSection TODO
            }
            .padding()
            .navigationBarHidden(true)
            .alert("Error", isPresented: $viewModel.hasError) {
                Button("OK", role: .cancel) {
                    viewModel.clearError()
                }
            } message: {
                Text(viewModel.errorMessage ?? "")
            }

            .overlay {
                if viewModel.isLoading {
                    ProgressView("Signing in...")
                        .padding()
                        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 12))
                }
            }.accessibilityElement(children: .contain)
            .accessibilityLabel("Login Screen")
        }
    }

    private func signIn() {
        Task { await viewModel.signIn() }
    }

    private var headerSection: some View {
        VStack(spacing: 16) {
            Image(systemName: "flame.fill")
                .font(.system(size: 60))
                .padding(.top, 60)
                .accessibilityHidden(true)

            VStack(spacing: 8) {
                Text("Welcome to")
                    .font(.title2)
                    .foregroundColor(.secondary)
                Text("Ogonek")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
            }
        }.accessibilityElement(children: .combine)
            .accessibilityLabel("Welcome to Ogonek")
            .accessibilityAddTraits(.isHeader)
    }

    private var loginForm: some View {
        VStack {
            TextField("Username", text: $viewModel.username)
                .focused($focusedField, equals: .username)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .submitLabel(.next)
                .onSubmit { focusedField = .password }

            SecureField("Password", text: $viewModel.password)
                .focused($focusedField, equals: .password)
                .submitLabel(.go)
                .onSubmit { signIn() }
        }
        .textFieldStyle(.roundedBorder)
        .padding()
    }

    private var loginButton: some View {
        Button(action: signIn) {
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
        .accessibilityLabel(viewModel.isLoading ? "Signing in, please wait" : "Sign in")
        .accessibilityHint(viewModel.canSignIn ? "Double tap to sign in with entered credentials" : "Enter username and password first")
        .accessibilityAddTraits(viewModel.isLoading ? [.updatesFrequently] : [])
        .accessibilityValue(viewModel.isLoading ? "In progress" : (viewModel.canSignIn ? "Available" : "Disabled"))
    }
}

// MARK: - Preview

#Preview {
    LoginView()
}
