//
//  Tokens.swift
//  Ogonek
//
//  Created by Danila Volkov on 31.07.2025.
//

import Foundation

class TokenStorage {
    private static let accessTokenKey = "access_token"
    private static let refreshTokenKey = "refresh_token"

    static func store(token: String, refreshToken: String) {
        UserDefaults.standard.set(token, forKey: accessTokenKey)
        UserDefaults.standard.set(refreshToken, forKey: refreshTokenKey)
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
