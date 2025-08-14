    //
    //  MockAPIService.swift
    //  OgonekTests
    //
    //  Created on 14.08.2025.
    //  Target Membership: OgonekTests + OgonekUITests

import Foundation
@testable import Ogonek

    // MARK: - Mock API Service for Unit Tests
class MockAPIService: APIServiceProtocol {
    var signInCalled = false
    var lastSignInUsername: String?
    var lastSignInPassword: String?
    var shouldThrowError: Error?
    var shouldDelay = false

    @MainActor
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
        TokenManager.shared.isAuthenticated = true
    }

        // Reset method for clean test state
    func reset() {
        signInCalled = false
        lastSignInUsername = nil
        lastSignInPassword = nil
        shouldThrowError = nil
        shouldDelay = false
    }
}

    // MARK: - UI Test Mock API Service
class UITestMockAPIService: APIServiceProtocol {
    func signIn(username: String, password: String) async throws {
            // Add small delay to simulate network
        try await Task.sleep(nanoseconds: 100_000_000) // 0.1 seconds

            // Check test configuration and respond accordingly
        if TestConfiguration.shouldMockSlowLogin {
            try await Task.sleep(nanoseconds: 2_000_000_000) // 2 seconds
        }

        if TestConfiguration.shouldMockNetworkError {
            throw URLError(.notConnectedToInternet)
        }

        if TestConfiguration.shouldMockLoginFailure {
            throw APIError.unauthorized
        }

        if TestConfiguration.shouldMockLoginSuccess {
            await MainActor.run {
                TokenManager.shared.isAuthenticated = true
            }
            return
        }

            // Default behavior - simple credential check
        if username == TestData.validUsername && password == TestData.validPassword {
            await MainActor.run {
                TokenManager.shared.isAuthenticated = true
            }
        } else {
            throw APIError.unauthorized
        }
    }
}
