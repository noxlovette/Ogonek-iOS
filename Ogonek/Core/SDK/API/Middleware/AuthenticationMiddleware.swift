//
//  AuthenticationMiddleware.swift
//  Ogonek
//
//  Created by Danila Volkov on 31.07.2025.
//

import Foundation
import HTTPTypes
import OpenAPIRuntime

/// A client middleware that injects a Bearer token into the `Authorization` header field of requests.
///
/// This middleware automatically adds authentication headers to all API requests,
/// supporting both static tokens and dynamic token providers.
struct AuthenticationMiddleware {
    /// The authentication strategy to use
    private let strategy: AuthStrategy

    /// Different authentication strategies
    private enum AuthStrategy {
        case bearer(String)
        case provider(() async throws -> String)
    }

    /// Creates a new middleware with a static Bearer token.
    /// - Parameter token: The Bearer token to use for authentication
    init(bearerToken token: String) {
        strategy = .bearer("Bearer \(token)")
    }

    /// Creates a new middleware with a dynamic token provider.
    /// - Parameter tokenProvider: An async closure that provides the current token
    init(tokenProvider: @escaping () async throws -> String) {
        strategy = .provider {
            let token = try await tokenProvider()
            return "Bearer \(token)"
        }
    }

    /// Creates a new middleware with a raw authorization header value.
    /// - Parameter value: The complete authorization header value (e.g., "Bearer token123")
    init(authorizationHeaderValue value: String) {
        strategy = .bearer(value)
    }
}

extension AuthenticationMiddleware: ClientMiddleware {
    func intercept(
        _ request: HTTPRequest,
        body: HTTPBody?,
        baseURL: URL,
        operationID _: String,
        next: (HTTPRequest, HTTPBody?, URL) async throws -> (HTTPResponse, HTTPBody?),
    ) async throws -> (HTTPResponse, HTTPBody?) {
        var mutableRequest = request

        // Get the authorization header value based on strategy
        let authValue: String = switch strategy {
        case let .bearer(value):
            value
        case let .provider(provider):
            try await provider()
        }

        // Set the authorization header
        mutableRequest.headerFields[.authorization] = authValue

        return try await next(mutableRequest, body, baseURL)
    }
}
