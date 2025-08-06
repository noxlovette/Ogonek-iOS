import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

    /// Main API client that handles both authenticated and unauthenticated requests
public class OpenAPIClient {
    var client: Client
    private var authMiddleware: AuthenticationMiddleware?
    private var apiKeyMiddleware: APIKeyMiddleware
    private var tokenRefreshMiddleware: TokenRefreshMiddleware?
    private let clientQueue = DispatchQueue(label: "openapi.client.queue", qos: .userInitiated)
    private var isSettingUpAuth = false

        /// Initialize with no authentication (for login/signup)
    init() {
        let apiKey = ProcessInfo.processInfo.environment["API_KEY"]
        apiKeyMiddleware = APIKeyMiddleware(apiKey: apiKey!)

        do {
            client = try Client(
                serverURL: Servers.Server2.url(),
                transport: URLSessionTransport(),
                middlewares: [apiKeyMiddleware],
            )
        } catch {
            fatalError("Failed to initialize OpenAPI client: \(error)")
        }
    }

        /// Add authentication after successful login
    func setAuthToken(_ token: String) {
        clientQueue.sync {
            guard !isSettingUpAuth else { return }
            isSettingUpAuth = true

            defer { isSettingUpAuth = false }

            do {
                let authMiddleware = AuthenticationMiddleware(tokenProvider: {
                        // Always get the latest token from storage
                    guard let currentToken = TokenStorage.getAccessToken() else {
                        throw TokenRefreshError.noRefreshToken
                    }
                    return currentToken
                })
                let tokenRefreshMiddleware = TokenRefreshMiddleware()
                client = try Client(
                    serverURL: Servers.Server2.url(),
                    transport: URLSessionTransport(),
                    middlewares: [
                        apiKeyMiddleware,
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

        /// Remove authentication (for logout)
    func clearAuth() {
        clientQueue.sync {
            do {
                client = try Client(
                    serverURL: Servers.Server1.url(),
                    transport: URLSessionTransport(),
                    middlewares: [apiKeyMiddleware],
                )
                authMiddleware = nil
                tokenRefreshMiddleware = nil
                print("✅ OpenAPI client auth cleared")
            } catch {
                print("❌ Failed to clear auth from client: \(error)")
            }
        }
    }

        /// Check if client is authenticated
    var isAuthenticated: Bool {
        clientQueue.sync {
            return authMiddleware != nil && !isSettingUpAuth
        }
    }
}
