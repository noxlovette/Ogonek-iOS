//
//  APIService.swift
//  Ogonek
//
//  Created by Danila Volkov on 31.07.2025.
//

import Combine
import Foundation

public final class APIService: ObservableObject {
    @MainActor
    var disposeBag = Set<AnyCancellable>()

    let openAPIClient: OpenAPIClient

    static var shared: APIService {
        APIService()
    }

    private init() {
        // Initialize OpenAPI client
        openAPIClient = OpenAPIClient()

        // setup cache. 10MB RAM + 50MB Disk
        URLCache.shared = URLCache(memoryCapacity: 10 * 1024 * 1024, diskCapacity: 50 * 1024 * 1024, diskPath: nil)

        // Try to restore authentication from stored tokens
        restoreAuthenticationIfAvailable()
    }

    // MARK: - OpenAPI Client Access

    /// Access to the OpenAPI client for making authenticated/unauthenticated requests
    public var client: OpenAPIClient {
        openAPIClient
    }
}

// MARK: - Extensions for Constants

public extension APIService {
    static let onceRequestStatusMaxCount = 100
    static let onceRequestUserMaxCount = 100
    static let onceRequestDomainBlocksMaxCount = 100
}
