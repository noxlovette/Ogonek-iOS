//
//  Tokens.swift
//  Ogonek
//
//  Created by Danila Volkov on 31.07.2025.
//

import Foundation
import KeychainAccess

/// Handles secure token storage using Keychain Services
class TokenStorage {
    private static let keychain = Keychain(service: "noxlovette.Ogonek-Swift")
        .synchronizable(false) // Don't sync to iCloud for security
        .accessibility(.whenUnlockedThisDeviceOnly) // Only accessible when device is unlocked

    private static let accessTokenKey = "access_token"
    private static let refreshTokenKey = "refresh_token"

    static func store(token: String, refreshToken: String) {
        do {
            try keychain.set(token, key: accessTokenKey)
            try keychain.set(refreshToken, key: refreshTokenKey)
            print("✅ Tokens stored securely in keychain")
        } catch {
            print("❌ Failed to store tokens in keychain: \(error)")
        }
    }

    static func refresh(token: String) {
        do {
            try keychain.set(token, key: accessTokenKey)
            print("✅ Access token refreshed in keychain")
        } catch {
            print("❌ Failed to refresh token in keychain: \(error)")
        }
    }

    static func getAccessToken() -> String? {
        do {
            return try keychain.get(accessTokenKey)
        } catch {
            print("❌ Failed to retrieve access token from keychain: \(error)")
            return nil
        }
    }

    static func getRefreshToken() -> String? {
        do {
            return try keychain.get(refreshTokenKey)
        } catch {
            print("❌ Failed to retrieve refresh token from keychain: \(error)")
            return nil
        }
    }

    static func clearTokens() {
        do {
            try keychain.remove(accessTokenKey)
            try keychain.remove(refreshTokenKey)
            print("✅ Tokens cleared from keychain")
        } catch {
            print("❌ Failed to clear tokens from keychain: \(error)")
        }
    }

    static func hasValidTokens() -> Bool {
        return getAccessToken() != nil
    }

    // Optional: Method to check if keychain is accessible
    static func isKeychainAccessible() -> Bool {
        do {
            // Try to set and retrieve a test value
            let testKey = "keychain_test"
            let testValue = "test"
            try keychain.set(testValue, key: testKey)
            let retrieved = try keychain.get(testKey)
            try keychain.remove(testKey)
            return retrieved == testValue
        } catch {
            print("❌ Keychain not accessible: \(error)")
            return false
        }
    }
}

/// Token manager that integrates with OpenAPI Service
@MainActor
final class TokenManager: ObservableObject {
    static let shared = TokenManager()

    init() {
        isAuthenticated = TokenStorage.hasValidTokens()
        apiService = .shared
    }

    @Published var isAuthenticated = false
    @Published var currentUser: User?

    private var refreshInProgress = false
    private let refreshQueue = DispatchQueue(label: "tokenRefresh", qos: .userInitiated)
    private var apiService: APIService

    // MARK: - Token Refresh Logic

    /// Attempt to refresh the access token
    /// Returns true if refresh was successful, false otherwise
    func attemptTokenRefresh() async -> Bool {
        // Prevent concurrent refresh attempts
        guard !refreshInProgress else {
            // Wait and return current state
            try? await Task.sleep(nanoseconds: 200_000_000) // 0.2 seconds
            return isAuthenticated
        }

        refreshInProgress = true
        defer { refreshInProgress = false }

        guard let refreshToken = TokenStorage.getRefreshToken() else {
            print("❌ No refresh token available")
            apiService.logout()
            isAuthenticated = false
            return false
        }

        do {
            try await apiService.refresh(refreshToken: refreshToken)
            print("👍 Refreshed access token")
            let accessToken = TokenStorage.getAccessToken()!
            print(accessToken)
            isAuthenticated = true
            return true
        } catch {
            print("❌ Token refresh error: \(error)")
            isAuthenticated = false
            return false
        }
    }

    private func performTokenRefresh() async -> Bool {
        guard let refreshToken = TokenStorage.getRefreshToken() else {
            print("❌ No refresh token available")
            apiService.logout()
            return false
        }

        do {
            try await apiService.refresh(refreshToken: refreshToken)
            isAuthenticated = true
            return true
        } catch {
            print("❌ Token refresh error: \(error)")
            isAuthenticated = false
            return false
        }
    }

    func logout() {
        apiService.logout()
        TokenStorage.clearTokens()
        isAuthenticated = false
        currentUser = nil
    }
}

enum TokenRefreshError: Error, LocalizedError {
    case maxRetriesExceeded
    case noRefreshToken
    case refreshFailed

    var errorDescription: String? {
        switch self {
        case .maxRetriesExceeded:
            "Maximum token refresh retries exceeded"
        case .noRefreshToken:
            "No refresh token available"
        case .refreshFailed:
            "Token refresh failed"
        }
    }
}
