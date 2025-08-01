    //
    //  APIKeyMiddleware.swift
    //  Ogonek
    //
    //  Created by Developer on 01.08.2025.
    //

import Foundation
import HTTPTypes
import OpenAPIRuntime

    /// A client middleware that injects a static API key into the `x-api-key` header field of all requests.
struct APIKeyMiddleware {
    private let apiKey: String

        /// Creates a new middleware with a static API key.
        /// - Parameter apiKey: The API key to use for all requests
    init(apiKey: String) {
        self.apiKey = apiKey
    }
}

extension APIKeyMiddleware: ClientMiddleware {
    func intercept(
        _ request: HTTPRequest,
        body: HTTPBody?,
        baseURL: URL,
        operationID _: String,
        next: (HTTPRequest, HTTPBody?, URL) async throws -> (HTTPResponse, HTTPBody?),
    ) async throws -> (HTTPResponse, HTTPBody?) {
        var mutableRequest = request

            // Always add the x-api-key header
        mutableRequest.headerFields[HTTPField.Name("x-api-key")!] = apiKey

        return try await next(mutableRequest, body, baseURL)
    }
}
