    //
    //  TestConfiguration.swift
    //  Ogonek
    //
    //  Created on 14.08.2025.
    //  Target Membership: Main App + OgonekTests + OgonekUITests

import Foundation
@testable import Ogonek

    // MARK: - Test Configuration
struct TestConfiguration {
    static var isRunningTests: Bool {
        ProcessInfo.processInfo.arguments.contains("--testing") ||
        ProcessInfo.processInfo.environment["TESTING_MODE"] == "1"
    }

    static var shouldMockLoginSuccess: Bool {
        ProcessInfo.processInfo.environment["MOCK_LOGIN_SUCCESS"] == "true"
    }

    static var shouldMockLoginFailure: Bool {
        ProcessInfo.processInfo.environment["MOCK_LOGIN_FAILURE"] == "true"
    }

    static var shouldMockSlowLogin: Bool {
        ProcessInfo.processInfo.environment["MOCK_LOGIN_SLOW"] == "true"
    }

    static var shouldMockNetworkError: Bool {
        ProcessInfo.processInfo.environment["MOCK_NETWORK_ERROR"] == "true"
    }
}

    // MARK: - Test Data
struct TestData {
        // Test credentials
    static let validUsername = "testuser"
    static let validPassword = "testpassword"
    static let invalidUsername = "invaliduser"
    static let invalidPassword = "invalidpassword"

        // Expected error messages (should match your LoginViewModel)
    static let unauthorizedErrorMessage = "Invalid username or password"
    static let serverErrorMessage = "Server error (500). Please try again."
    static let networkErrorMessage = "Login failed. Please check your connection and try again."
}

    // MARK: - Basic Test Helpers
struct TestHelpers {
    @MainActor
    static func setupCleanTestState() {
        TokenManager.shared.logout()
            // Add any other cleanup needed
    }
}
