import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

extension OpenAPIClient {
    func registerDevice(_ token: String) async throws {
        let payload = Components.Schemas.DeviceTokenPayload(
            platform: "ios",
            token: token
        )

        let input = Operations.RegisterDeviceToken.Input(
            body: .json(payload)
        )

        let response = try await client.registerDeviceToken(input)

        switch response {
            case .noContent:
                print("ok")
            case .unauthorized:
                throw APIError.unauthorized
            case let .undocumented(statusCode: statusCode, _):
                throw APIError.serverError(statusCode: statusCode)
        }
    }

}
