    //
    //  AuthenticationMiddleware.swift
    //  Ogonek
    //
    //  Created by Danila Volkov on 31.07.2025.
    //

import OpenAPIRuntime
import Foundation
import HTTPTypes

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
        self.strategy = .bearer("Bearer \(token)")
    }

        /// Creates a new middleware with a dynamic token provider.
        /// - Parameter tokenProvider: An async closure that provides the current token
    init(tokenProvider: @escaping () async throws -> String) {
        self.strategy = .provider {
            let token = try await tokenProvider()
            return "Bearer \(token)"
        }
    }

        /// Creates a new middleware with a raw authorization header value.
        /// - Parameter value: The complete authorization header value (e.g., "Bearer token123")
    init(authorizationHeaderValue value: String) {
        self.strategy = .bearer(value)
    }
}

extension AuthenticationMiddleware: ClientMiddleware {
    func intercept(
        _ request: HTTPRequest,
        body: HTTPBody?,
        baseURL: URL,
        operationID: String,
        next: (HTTPRequest, HTTPBody?, URL) async throws -> (HTTPResponse, HTTPBody?)
    ) async throws -> (HTTPResponse, HTTPBody?) {
        var mutableRequest = request

            // Get the authorization header value based on strategy
        let authValue: String
        switch strategy {
            case .bearer(let value):
                authValue = value
            case .provider(let provider):
                authValue = try await provider()
        }

            // Set the authorization header
        mutableRequest.headerFields[.authorization] = authValue

        return try await next(mutableRequest, body, baseURL)
    }
}
