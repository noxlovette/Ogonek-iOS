    //
    //  APIService.swift
    //  Ogonek
    //
    //  Created by Danila Volkov on 31.07.2025.
    //

import Foundation
import Combine

@MainActor
public final class APIService {

    @MainActor
    public static let shared = { APIService() }()

    var disposeBag = Set<AnyCancellable>()

        // OpenAPI client for modern API calls
    private let openAPIClient: OpenAPIClient

        // output
    public let error = PassthroughSubject<APIError, Never>()

    private init() {
            // Initialize OpenAPI client
        self.openAPIClient = OpenAPIClient()

            // setup cache. 10MB RAM + 50MB Disk
        URLCache.shared = URLCache(memoryCapacity: 10 * 1024 * 1024, diskCapacity: 50 * 1024 * 1024, diskPath: nil)

            // Try to restore authentication from stored tokens
        restoreAuthenticationIfAvailable()
    }

    public static func isolatedService() -> APIService {
        return APIService()
    }

        // MARK: - OpenAPI Client Access

        /// Access to the OpenAPI client for making authenticated/unauthenticated requests
    public var client: OpenAPIClient {
        return openAPIClient
    }

   }
}

    // MARK: - Extensions for Constants
extension APIService {
    public static let onceRequestStatusMaxCount = 100
    public static let onceRequestUserMaxCount = 100
    public static let onceRequestDomainBlocksMaxCount = 100
}
