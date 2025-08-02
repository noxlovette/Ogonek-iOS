//
//  Tokens.swift
//  Ogonek
//
//  Created by Danila Volkov on 31.07.2025.
//

import Foundation


/// Handles only token storage
class TokenStorage {
    private static let accessTokenKey = "access_token"
    private static let refreshTokenKey = "refresh_token"

    static func store(token: String, refreshToken: String) {
        UserDefaults.standard.set(token, forKey: accessTokenKey)
        UserDefaults.standard.set(refreshToken, forKey: refreshTokenKey)
    }

    static func refresh(token: String)
    {
        UserDefaults.standard.set(token, forKey: accessTokenKey)
    }

    static func getAccessToken() -> String? {
        UserDefaults.standard.string(forKey: accessTokenKey)
    }

    static func getRefreshToken() -> String? {
        UserDefaults.standard.string(forKey: refreshTokenKey)
    }

    static func clearTokens() {
        UserDefaults.standard.removeObject(forKey: accessTokenKey)
        UserDefaults.standard.removeObject(forKey: refreshTokenKey)
    }

    static func hasValidTokens() -> Bool {
        getAccessToken() != nil
    }
}

    /// Token manager that integrates with OpenAPI Service
@MainActor
final class TokenManager: ObservableObject  {
    static let shared = TokenManager()

    init(){
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
                self.isAuthenticated = true
            return true
        } catch {
            print("❌ Token refresh error: \(error)")
                self.isAuthenticated = false
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
                return "Maximum token refresh retries exceeded"
            case .noRefreshToken:
                return "No refresh token available"
            case .refreshFailed:
                return "Token refresh failed"
        }
    }
}

