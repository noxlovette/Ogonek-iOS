//
//  LoginView.swift
//  Ogonek
//
//  Created by Danila Volkov on 01.08.2025.
//

import SwiftUI

struct LoginView: View {
    @Bindable private var viewModel = LoginViewModel()
    @FocusState private var focusedField: Field?

    enum Field: Hashable {
        case username, password
    }

    var body: some View {
        NavigationStack {
            Form {
                headerSection

                Section {
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

                Section {
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
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .disabled(viewModel.password.isEmpty || viewModel.username.isEmpty)
                }
            }
            .navigationTitle("Login")
            .navigationBarTitleDisplayMode(.inline)
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
            }
            .accessibilityElement(children: .contain)
            .accessibilityLabel("Login Screen")
        }
    }

    private func signIn() {
        Task { await viewModel.signIn() }
    }

    private var headerSection: some View {
        Section {
            VStack(spacing: 12) {
                Image(systemName: "flame.fill")
                    .font(.system(size: 60))
                    .padding(.top, 20)
                    .frame(maxWidth: .infinity)
                    .accessibilityHidden(true)

                VStack(spacing: 4) {
                    Text("Welcome to")
                        .font(.title2)
                        .foregroundColor(.secondary)
                    Text("Ogonek")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                }
                .frame(maxWidth: .infinity)
            }
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
        }
    }
}

// MARK: - Preview

#Preview {
    LoginView()
}
