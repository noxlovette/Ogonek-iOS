import Foundation
import OpenAPIURLSession
import OpenAPIRuntime

    /// Main API client that handles both authenticated and unauthenticated requests
public class OpenAPIClient  {
    var client: Client
    private var authMiddleware: AuthenticationMiddleware?

        /// Initialize with no authentication (for login/signup)
    init() {
        do {
            self.client = Client(
                serverURL: try Servers.Server1.url(),
                transport: URLSessionTransport()
            )
        } catch {
            fatalError("Failed to initialize OpenAPI client: \(error)")
        }
    }

        /// Add authentication after successful login
    func setAuthToken(_ token: String) {
        do {
            let authMiddleware = AuthenticationMiddleware(bearerToken: token)
            self.client = Client(
                serverURL: try Servers.Server1.url(),
                transport: URLSessionTransport(),
                middlewares: [authMiddleware]
            )
            self.authMiddleware = authMiddleware
        } catch {
            print("Failed to update client with auth token: \(error)")
        }
    }

        /// Remove authentication (for logout)
    func clearAuth() {
        do {
            self.client = Client(
                serverURL: try Servers.Server1.url(),
                transport: URLSessionTransport()
            )
            self.authMiddleware = nil
        } catch {
            print("Failed to clear auth from client: \(error)")
        }
    }

        /// Check if client is authenticated
    var isAuthenticated: Bool {
        return authMiddleware != nil
    }
}
