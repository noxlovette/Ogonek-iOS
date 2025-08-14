//
//  APIService.swift
//  Ogonek
//
//  Created by Danila Volkov on 31.07.2025.
//

import Combine
import Foundation

public final class APIService: ObservableObject {
    @MainActor
    var disposeBag = Set<AnyCancellable>()

    let openAPIClient: OpenAPIClient

    static var shared: APIService {
        APIService()
    }

    private init() {
        openAPIClient = OpenAPIClient()

        URLCache.shared = URLCache(memoryCapacity: 10 * 1024 * 1024, diskCapacity: 50 * 1024 * 1024, diskPath: nil)

        restoreAuthenticationIfAvailable()
    }

    // MARK: - OpenAPI Client Access
    public var client: OpenAPIClient {
        openAPIClient
    }
}

// MARK: - Extensions for Constants
public extension APIService {
    static let onceRequestStatusMaxCount = 100
    static let onceRequestUserMaxCount = 100
    static let onceRequestDomainBlocksMaxCount = 100
}


// MARK: Dependency Injections
protocol APIServiceProtocol {
    func signIn(username: String, password: String) async throws
}

extension APIService: APIServiceProtocol {
}

    // MARK: - Mock API Service for UI Tests

#if DEBUG
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
#endif

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

            // Simulate successful login
        await MainActor.run {
            TokenManager.shared.isAuthenticated = true
        }
    }
}
#endif
