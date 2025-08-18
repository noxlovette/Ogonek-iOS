import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

/// Main API client that handles both authenticated and unauthenticated requests
public class OpenAPIClient {
    var client: Client
    private var authMiddleware: AuthenticationMiddleware?
    private var tokenRefreshMiddleware: TokenRefreshMiddleware?
    private let clientQueue = DispatchQueue(label: "openapi.client.queue", qos: .userInitiated)
    private var isSettingUpAuth = false

    /// Initialize with no authentication (for login/signup)
    init() {
        do {
            client = try Client(
                serverURL: EnvironmentConfig.serverURL(),
                transport: URLSessionTransport(),
            )
        } catch {
            fatalError("Failed to initialize OpenAPI client: \(error)")
        }
    }

    /// Add authentication after successful login
    func setAuthToken(_: String) {
        clientQueue.sync {
            guard !isSettingUpAuth else { return }
            isSettingUpAuth = true

            defer { isSettingUpAuth = false }

            do {
                let authMiddleware = AuthenticationMiddleware(tokenProvider: {
                    guard let currentToken = TokenStorage.getAccessToken() else {
                        throw TokenRefreshError.noRefreshToken
                    }
                    return currentToken
                })
                let tokenRefreshMiddleware = TokenRefreshMiddleware()
                client = try Client(
                    serverURL: EnvironmentConfig.serverURL(),
                    transport: URLSessionTransport(),
                    middlewares: [
                        authMiddleware,
                        tokenRefreshMiddleware,
                    ],
                )
                self.authMiddleware = authMiddleware
                self.tokenRefreshMiddleware = tokenRefreshMiddleware

                print("✅ OpenAPI client auth setup complete")
            } catch {
                print("❌ Failed to update client with auth token: \(error)")
            }
        }
    }

    func clearAuth() {
        clientQueue.sync {
            do {
                client = try Client(
                    serverURL: EnvironmentConfig.serverURL(),
                    transport: URLSessionTransport(),
                )
                authMiddleware = nil
                tokenRefreshMiddleware = nil
                print("✅ OpenAPI client auth cleared")
            } catch {
                print("❌ Failed to clear auth from client: \(error)")
            }
        }
    }

    var isAuthenticated: Bool {
        clientQueue.sync {
            authMiddleware != nil && !isSettingUpAuth
        }
    }
}

enum AppEnvironment: String {
    case production
    case staging
    case development
}

enum EnvironmentConfig {
    static func currentEnvironment() -> AppEnvironment {
        #if STAGING
            return .staging
        #elseif DEBUG
            return .development
        #else
            return .production
        #endif
    }

    static func serverURL() throws -> URL {
        switch currentEnvironment() {
        case .production:
            return try Servers.Server1.url()
        case .staging:
            return try Servers.Server2.url()
        case .development:
            return try Servers.Server3.url()
        }
    }
}
