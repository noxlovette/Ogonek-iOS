//
//  LoginViewModelTests.swift
//  OgonekUITests
//
//  Created by Danila Volkov on 14.08.2025.
//

import Foundation
import Testing
import ZipArchive
@testable import Ogonek

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

@MainActor
struct LoginViewModelTests {

        // MARK: - Form Validation Tests
    @Test("Initial state should prevent sign in")
    func testInitialState() {
        let viewModel = LoginViewModel()

        #expect(viewModel.username.isEmpty)
        #expect(viewModel.password.isEmpty)
        #expect(!viewModel.canSignIn)
        #expect(!viewModel.isLoading)
        #expect(viewModel.errorMessage == nil)
        #expect(!viewModel.hasError)
    }

    @Test("Username with only whitespace should prevent sign in")
    func testUsernameWithWhitespaceOnly() {
        let viewModel = LoginViewModel()

        viewModel.username = "   \t\n  "
        viewModel.password = "validPassword"

        #expect(!viewModel.canSignIn)
    }

    @Test("Empty password should prevent sign in")
    func testEmptyPassword() {
        let viewModel = LoginViewModel()

        viewModel.username = "validUser"
        viewModel.password = ""

        #expect(!viewModel.canSignIn)
    }

    @Test("Valid credentials should allow sign in")
    func testValidCredentials() {
        let viewModel = LoginViewModel()

        viewModel.username = "validUser"
        viewModel.password = "validPassword"

        #expect(viewModel.canSignIn)
    }

    @Test("Loading state should prevent sign in")
    func testLoadingStatePreventsSignIn() {
        let viewModel = LoginViewModel()

        viewModel.username = "validUser"
        viewModel.password = "validPassword"
        viewModel.isLoading = true

        #expect(!viewModel.canSignIn)
    }

        // MARK: - Error State Tests

    @Test("Setting error message should set hasError to true")
    func testErrorMessageSetsHasError() {
        let viewModel = LoginViewModel()

        viewModel.errorMessage = "Test error"

        #expect(viewModel.hasError)
    }

    @Test("Clearing error should set hasError to false")
    func testClearingErrorSetsHasErrorToFalse() {
        let viewModel = LoginViewModel()

        viewModel.errorMessage = "Test error"
        viewModel.hasError = false

        #expect(viewModel.errorMessage == nil)
        #expect(!viewModel.hasError)
    }

    @Test("clearError() should remove error message")
    func testClearErrorMethod() {
        let viewModel = LoginViewModel()

        viewModel.errorMessage = "Test error"
        viewModel.clearError()

        #expect(viewModel.errorMessage == nil)
        #expect(!viewModel.hasError)
    }

        // MARK: - Form Clearing Tests

    @Test("clearForm() should reset all form fields")
    func testClearForm() {
        let viewModel = LoginViewModel()

        viewModel.username = "testUser"
        viewModel.password = "testPassword"
        viewModel.errorMessage = "Test error"

        viewModel.clearForm()

        #expect(viewModel.username.isEmpty)
        #expect(viewModel.password.isEmpty)
        #expect(viewModel.errorMessage == nil)
    }

        // MARK: - Authentication Tests (with Mock)

    @Test("Successful sign in should clear loading state and not set error")
    func testSuccessfulSignIn() async {
            // Create a view model with a mock API service
        let mockAPIService = MockAPIService()
        let viewModel = LoginViewModel(apiService: mockAPIService)

        viewModel.username = "testUser"
        viewModel.password = "testPassword"

        await viewModel.signIn()

        #expect(!viewModel.isLoading)
        #expect(viewModel.errorMessage == nil)
        #expect(mockAPIService.signInCalled)
        #expect(mockAPIService.lastSignInUsername == "testUser")
        #expect(mockAPIService.lastSignInPassword == "testPassword")
    }

    @Test("Sign in should trim username whitespace")
    func testSignInTrimsUsername() async {
        let mockAPIService = MockAPIService()
        let viewModel = LoginViewModel(apiService: mockAPIService)

        viewModel.username = "  testUser  "
        viewModel.password = "testPassword"

        await viewModel.signIn()

        #expect(mockAPIService.lastSignInUsername == "testUser")
    }

    @Test("Unauthorized error should set appropriate error message")
    func testUnauthorizedError() async {
        let mockAPIService = MockAPIService()
        mockAPIService.shouldThrowError = APIError.unauthorized
        let viewModel = LoginViewModel(apiService: mockAPIService)

        viewModel.username = "wrongUser"
        viewModel.password = "wrongPassword"

        await viewModel.signIn()

        #expect(!viewModel.isLoading)
        #expect(viewModel.errorMessage == "Invalid username or password")
        #expect(viewModel.hasError)
    }

    @Test("Server error should set appropriate error message")
    func testServerError() async {
        let mockAPIService = MockAPIService()
        mockAPIService.shouldThrowError = APIError.serverError(statusCode: 500)
        let viewModel = LoginViewModel(apiService: mockAPIService)

        viewModel.username = "testUser"
        viewModel.password = "testPassword"

        await viewModel.signIn()

        #expect(!viewModel.isLoading)
        #expect(viewModel.errorMessage == "Server error (500). Please try again.")
        #expect(viewModel.hasError)
    }

    @Test("Network error should set generic error message")
    func testNetworkError() async {
        let mockAPIService = MockAPIService()
        mockAPIService.shouldThrowError = URLError(.notConnectedToInternet)
        let viewModel = LoginViewModel(apiService: mockAPIService)

        viewModel.username = "testUser"
        viewModel.password = "testPassword"

        await viewModel.signIn()

        #expect(!viewModel.isLoading)
        #expect(viewModel.errorMessage == "Login failed. Please check your connection and try again.")
        #expect(viewModel.hasError)
    }

    @Test("Sign in should not proceed if canSignIn is false")
    func testSignInWithInvalidForm() async {
        let mockAPIService = MockAPIService()
        let viewModel = LoginViewModel(apiService: mockAPIService)

            // Leave username empty
        viewModel.password = "testPassword"

        await viewModel.signIn()

        #expect(!mockAPIService.signInCalled)
        #expect(!viewModel.isLoading)
    }

    @Test("Loading state should be set during sign in")
    func testLoadingStatesDuringSignIn() async {
        let mockAPIService = MockAPIService()
        mockAPIService.shouldDelay = true
        let viewModel = LoginViewModel(apiService: mockAPIService)

        viewModel.username = "testUser"
        viewModel.password = "testPassword"

        let signInTask = Task {
            await viewModel.signIn()
        }

            // Give a moment for the loading state to be set
        try? await Task.sleep(nanoseconds: 10_000_000) // 0.01 seconds

        #expect(viewModel.isLoading)

        await signInTask.value

        #expect(!viewModel.isLoading)
    }
}
