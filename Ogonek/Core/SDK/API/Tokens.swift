//
//  Tokens.swift
//  Ogonek
//
//  Created by Danila Volkov on 31.07.2025.
//

import Foundation

class TokenStorage {
    private static let tokenKey = "auth_token"
    private static let refreshTokenKey = "refresh_token"
    private static let tokenExpiryKey = "auth_token_expiry"
    private static let refreshTokenExpiryKey = "refresh_token_expiry"

    // Store TokenWithExpiry objects
    static func store(token: Components.Schemas.TokenWithExpiry, refreshToken: Components.Schemas.TokenWithExpiry? = nil) {
        UserDefaults.standard.set(token.token, forKey: tokenKey)
        UserDefaults.standard.set(token.expiresAt, forKey: tokenExpiryKey)

        if let refreshToken = refreshToken {
            UserDefaults.standard.set(refreshToken.token, forKey: refreshTokenKey)
            UserDefaults.standard.set(refreshToken.expiresAt, forKey: refreshTokenExpiryKey)
        }
    }

    // Get the actual token string
    static func getStoredToken() -> String? {
        return UserDefaults.standard.string(forKey: tokenKey)
    }

    static func getStoredRefreshToken() -> String? {
        return UserDefaults.standard.string(forKey: refreshTokenKey)
    }

    // Get expiry timestamps
    static func getTokenExpiry() -> Int64? {
        let expiry = UserDefaults.standard.object(forKey: tokenExpiryKey) as? Int64
        return expiry == 0 ? nil : expiry
    }

    static func getRefreshTokenExpiry() -> Int64? {
        let expiry = UserDefaults.standard.object(forKey: refreshTokenExpiryKey) as? Int64
        return expiry == 0 ? nil : expiry
    }

    // Check if token is expired (with 5 minute buffer)
    static func isTokenExpired() -> Bool {
        guard let expiry = getTokenExpiry() else { return true }
        let currentTime = Int64(Date().timeIntervalSince1970)
        return currentTime >= (expiry - 300) // 5 minute buffer
    }

    static func clearTokens() {
        UserDefaults.standard.removeObject(forKey: tokenKey)
        UserDefaults.standard.removeObject(forKey: refreshTokenKey)
        UserDefaults.standard.removeObject(forKey: tokenExpiryKey)
        UserDefaults.standard.removeObject(forKey: refreshTokenExpiryKey)
    }
}
