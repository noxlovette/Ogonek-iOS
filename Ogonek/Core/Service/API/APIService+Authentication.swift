//
//  APIService+Authentication.swift
//  Ogonek
//
//  Created by Danila Volkov on 31.07.2025.
//

import Foundation

extension APIService {
        /// Set authentication token (usually after successful login)
    public func setAuthToken(_ token: String) {
        openAPIClient.setAuthToken(token)
    }

        /// Clear authentication (for logout)
    public func clearAuth() {
        openAPIClient.clearAuth()
    }

        /// Check if the service is authenticated
    public var isAuthenticated: Bool {
        return openAPIClient.isAuthenticated
    }

        /// Restore authentication from stored tokens on app launch
    private func restoreAuthenticationIfAvailable() {
        if let storedToken = TokenStorage.getAccessToken() {
            setAuthToken(storedToken.token)
        }
    }

        // MARK: - Convenience Methods (delegate to OpenAPIClient)

        /// Sign in user
    public func signIn(username: String, password: String) async throws {
        try await openAPIClient.signIn(username: username, pass: password)
    }

        /// Logout user
    public func logout() {
        openAPIClient.logout()

    }
}
