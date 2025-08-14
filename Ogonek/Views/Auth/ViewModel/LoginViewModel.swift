//
//  LoginViewModel.swift
//  Ogonek
//
//  Created by Danila Volkov on 01.08.2025.
//

import Foundation

@Observable
class LoginViewModel: ObservableObject {
    @MainActor var username: String = ""
    @MainActor var password: String = ""
    @MainActor var isLoading = false
    @MainActor var errorMessage: String?

    @MainActor var canSignIn: Bool {
        !username.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !password.isEmpty &&
        !isLoading
    }

    @MainActor var hasError: Bool {
        get { errorMessage != nil }
        set { if !newValue { errorMessage = nil } }
    }

    private let apiService: APIServiceProtocol

        // Default initializer uses the shared APIService
    init() {
        self.apiService = APIService.shared
    }

        // Dependency injection initializer for testing
    init(apiService: APIServiceProtocol) {
        self.apiService = apiService
    }

    @MainActor
    func signIn() async {
        guard canSignIn else { return }
        isLoading = true
        errorMessage = nil

        let trimmedUsername = username.trimmingCharacters(in: .whitespacesAndNewlines)

        do {
            try await apiService.signIn(username: trimmedUsername, password: password)
            TokenManager.shared.isAuthenticated = true
            print("Login successful")
        } catch {
            switch error {
                case APIError.unauthorized:
                    errorMessage = "Invalid username or password"
                case let APIError.serverError(statusCode):
                    errorMessage = "Server error (\(statusCode)). Please try again."
                default:
                    errorMessage = "Login failed. Please check your connection and try again."
            }
            print("Login error: \(error)")
        }

        isLoading = false
    }

    @MainActor
    func clearForm() {
        username = ""
        password = ""
        errorMessage = nil
    }

    @MainActor
    func clearError() {
        errorMessage = nil
    }
}

    // MARK: - Mock API Service for Testing
#if DEBUG
class MockAPIService: APIServiceProtocol {
    var signInCalled = false
    var lastSignInUsername: String?
    var lastSignInPassword: String?
    var shouldThrowError: Error?
    var shouldDelay = false

    func signIn(username: String, password: String) async throws {
        signInCalled = true
        lastSignInUsername = username
        lastSignInPassword = password

        if shouldDelay {
            try await Task.sleep(nanoseconds: 100_000_000) // 0.1 seconds
        }

        if let error = shouldThrowError {
            throw error
        }

            // Simulate successful login by setting TokenManager
        await MainActor.run {
            TokenManager.shared.isAuthenticated = true
        }
    }
}
#endif

    // MARK: - Test Configuration Support
#if DEBUG
extension LoginViewModel {
    static func makeForTesting(
        mockSuccess: Bool = true,
        shouldDelay: Bool = false,
        errorToThrow: Error? = nil
    ) -> LoginViewModel {
        let mockService = MockAPIService()
        mockService.shouldDelay = shouldDelay

        if !mockSuccess {
            mockService.shouldThrowError = errorToThrow ?? APIError.unauthorized
        }

        return LoginViewModel(apiService: mockService)
    }
}
#endif
