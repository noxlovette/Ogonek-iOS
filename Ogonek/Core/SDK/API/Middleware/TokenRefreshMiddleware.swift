//
//  TokenRefreshMiddleware.swift
//  Ogonek
//
//  Token refresh middleware that automatically handles 401/403 responses
//  and retries the original request with a fresh token
//

import Foundation
import HTTPTypes
import OpenAPIRuntime

/// A client middleware that automatically handles token refresh on authentication failures
struct TokenRefreshMiddleware: ClientMiddleware {
    private let maxRetries: Int

    init(maxRetries: Int = 1) {
        self.maxRetries = maxRetries
    }

    func intercept(
        _ request: HTTPRequest,
        body: HTTPBody?,
        baseURL: URL,
        operationID _: String,
        next: (HTTPRequest, HTTPBody?, URL) async throws -> (HTTPResponse, HTTPBody?),
    ) async throws -> (HTTPResponse, HTTPBody?) {
        var attempts = 0
        var currentRequest = request

        while attempts <= maxRetries {
            let (response, responseBody) = try await next(currentRequest, body, baseURL)

            if response.status == .unauthorized || response.status == .forbidden {
                print("🔄 Token refresh triggered by \(response.status.reasonPhrase)")

                let refreshSucceeded = await TokenManager.shared.attemptTokenRefresh()

                if refreshSucceeded, attempts < maxRetries {
                    // Update the request with the new token
                    if let newToken = TokenStorage.getAccessToken() {
                        currentRequest.headerFields[.authorization] = "Bearer \(newToken)"
                    }
                    attempts += 1
                    continue
                } else {
                    return (response, responseBody)
                }
            }

            return (response, responseBody)
        }

        throw TokenRefreshError.maxRetriesExceeded
    }
}
