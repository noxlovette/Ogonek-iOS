import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

/// Main API client that handles both authenticated and unauthenticated requests
public class OpenAPIClient {
    var client: Client
    private var authMiddleware: AuthenticationMiddleware?
    private var apiKeyMiddleware: APIKeyMiddleware

    /// Initialize with no authentication (for login/signup)
    init() {
        let apiKey = ProcessInfo.processInfo.environment["API_KEY"]
        self.apiKeyMiddleware = APIKeyMiddleware(apiKey: apiKey!)

        do {
            client = try Client(
                serverURL: Servers.Server2.url(),
                transport: URLSessionTransport(),
                middlewares: [apiKeyMiddleware]
            )
        } catch {
            fatalError("Failed to initialize OpenAPI client: \(error)")
        }
    }

    /// Add authentication after successful login
    func setAuthToken(_ token: String) {
        do {
            let authMiddleware = AuthenticationMiddleware(bearerToken: token)
            client = try Client(
                serverURL: Servers.Server2.url(),
                transport: URLSessionTransport(),
                middlewares: [apiKeyMiddleware, authMiddleware],
            )
            self.authMiddleware = authMiddleware
        } catch {
            print("Failed to update client with auth token: \(error)")
        }
    }

    /// Remove authentication (for logout)
    func clearAuth() {
        do {
            client = try Client(
                serverURL: Servers.Server1.url(),
                transport: URLSessionTransport(),
            )
            authMiddleware = nil
        } catch {
            print("Failed to clear auth from client: \(error)")
        }
    }

    /// Check if client is authenticated
    var isAuthenticated: Bool {
        authMiddleware != nil
    }

}
