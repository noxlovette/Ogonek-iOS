//
//  APIService.swift
//  Ogonek
//
//  Created by Danila Volkov on 31.07.2025.
//

import Combine
import Foundation

@Observable
public final class APIService {
    @MainActor
    var disposeBag = Set<AnyCancellable>()

    let openAPIClient: OpenAPIClient

    static var shared: APIService {
        APIService()
    }

    private init() {
        openAPIClient = OpenAPIClient()

        URLCache.shared = URLCache(memoryCapacity: 10 * 1024 * 1024, diskCapacity: 50 * 1024 * 1024, diskPath: nil)

        restoreAuthenticationIfAvailable()
    }

    // MARK: - OpenAPI Client Access

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

extension APIService {
    func registerDevice(_ token: String) async throws {
        try await openAPIClient.registerDevice(token)
    }
}
