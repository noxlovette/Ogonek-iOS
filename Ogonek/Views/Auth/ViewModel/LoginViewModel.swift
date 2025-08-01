    //
    //  LoginViewModel.swift
    //  Ogonek
    //
    //  Created by Danila Volkov on 01.08.2025.
    //

import Foundation

@Observable
class LoginViewModel {
        // Form fields
    @MainActor var username: String = "dev_teacher1"
    @MainActor var password: String = "!7!N6x$#62j0fE3zdGnS"

        // Loading states
    @MainActor var isLoading = false
    @MainActor var errorMessage: String?

        // Computed properties
    @MainActor var canSignIn: Bool {
        !username.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !password.isEmpty &&
        !isLoading
    }

    private let apiService = APIService.shared

        /// Sign in the user with username and password
    @MainActor
    func signIn() async {
        guard canSignIn else { return }

        isLoading = true
        errorMessage = nil

        let trimmedUsername = username.trimmingCharacters(in: .whitespacesAndNewlines)

        do {
            try await apiService.signIn(username: trimmedUsername, password: password)
                // Success - the APIService handles token storage and authentication state
                // The app's authentication state should update automatically
            print("Login successful")
        } catch {
                // Handle different types of errors
            switch error {
                case APIError.unauthorized:
                    errorMessage = "Invalid username or password"
                case APIError.serverError(let statusCode):
                    errorMessage = "Server error (\(statusCode)). Please try again."
                default:
                    errorMessage = "Login failed. Please check your connection and try again."
            }
            print("Login error: \(error)")
        }

        isLoading = false
    }

        /// Clear form fields
    @MainActor
    func clearForm() {
        username = ""
        password = ""
        errorMessage = nil
    }

        /// Reset error state
    @MainActor
    func clearError() {
        errorMessage = nil
    }
}
