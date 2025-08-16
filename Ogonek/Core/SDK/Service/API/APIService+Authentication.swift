//
//  APIService+Authentication.swift
//  Ogonek
//
//  Created by Danila Volkov on 31.07.2025.
//

import Foundation

extension APIService {
    func signIn(username: String, password: String) async throws {
        try await openAPIClient.signIn(username: username, pass: password)
    }
}

public extension APIService {
    func setAuthToken(_ token: String) {
        openAPIClient.setAuthToken(token)
    }

    func clearAuth() {
        openAPIClient.clearAuth()
    }

    var isAuthenticated: Bool {
        openAPIClient.isAuthenticated
    }

    func restoreAuthenticationIfAvailable() {
        if let storedToken = TokenStorage.getAccessToken() {
            print("restoring access token")
            setAuthToken(storedToken)
        }
    }

    func logout() {
        openAPIClient.logout()
    }

    func refresh(refreshToken: String) async throws {
        try await openAPIClient.refresh(refreshToken: refreshToken)
    }
}
