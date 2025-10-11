//
//  OpenAPIClient+Files.swift
//  Ogonek
//
//  Extension for file-related API operations
//

import Foundation

extension OpenAPIClient {
    /// Get presigned download URLs for files
    func getPresignedDownloadURLs(encodedKey: String) async throws -> URL {
        let input = Operations.FetchPresignedUrl.Input.Path(
            encodedKey: encodedKey,
        )
        let response = try await client.fetchPresignedUrl(path: input)

        switch response {
        case let .ok(okResponse):
            let body = okResponse.body
            switch body {
            case let .json(presignedResponse):
                guard let url = URL(string: presignedResponse.url) else {
                    throw APIError.serverError(statusCode: 500)
                }
                return url
            }
        case .notFound:
            throw APIError.notFound
        case .badRequest:
            throw APIError.badRequest
        case .unauthorized:
            throw APIError.unauthorized
        case let .undocumented(statusCode: statusCode, _):
            throw APIError.serverError(statusCode: statusCode)
        }
    }

    /// Batch get presigned download URLs
    func getPresignedDownloadURLs(fileID: String) async throws -> PresignedURLResponse {
        let input = Operations.FetchPresignedUrlsBatch.Input.Path(
            taskId: fileID,
        )

        let response = try await client.fetchPresignedUrlsBatch(path: input)

        switch response {
        case let .ok(okResponse):
            let body = okResponse.body
            switch body {
            case let .json(presignedResponses):
                return presignedResponses
            }
        case .badRequest:
            throw APIError.serverError(statusCode: 400)
        case .unauthorized:
            throw APIError.unauthorized
        case let .undocumented(statusCode: statusCode, _):
            throw APIError.serverError(statusCode: statusCode)
        }
    }
}
