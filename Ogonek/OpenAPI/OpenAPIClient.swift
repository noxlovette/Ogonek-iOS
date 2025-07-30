import Foundation
import OpenAPIURLSession

public struct OpenAPIClient: APIProtocol {
    let client: Client

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
}
