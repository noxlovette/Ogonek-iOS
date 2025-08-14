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


// MARK: Dependency Injections
protocol APIServiceProtocol {
    func signIn(username: String, password: String) async throws
}

extension APIService: APIServiceProtocol {
}
