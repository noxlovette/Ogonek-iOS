//
//  APIError.swift
//  Ogonek
//
//  Created by Danila Volkov on 30.07.2025.
//

import Foundation

enum APIError: Error, LocalizedError {
    case unauthorized
    case notFound
    case networkError(Error)
    case decodingError(Error)
    case serverError(statusCode: Int)
    case badRequest
    case unknownError
    case invalidURL

    var errorDescription: String? {
        switch self {
        case .unauthorized:
            "Authentication required"
        case let .networkError(error):
            "Network error: \(error.localizedDescription)"
        case let .decodingError(error):
            "Data parsing error: \(error.localizedDescription)"
        case let .serverError(statusCode):
            "Server error (status: \(statusCode))"
        case .badRequest:
            "Bad request"
        case .unknownError:
            "An unknown error occurred"
        case .notFound:
            "Resource not found"
        case .invalidURL:
            "Invalid URL"
        }
    }
}

enum DownloadError: LocalizedError {
    case zipCreationFailed
    case noPresignedURLs
    case markdownConversionFailed

    var errorDescription: String? {
        switch self {
        case .zipCreationFailed:
            "Failed to create ZIP archive"
        case .noPresignedURLs:
            "No files to download"
        case .markdownConversionFailed:
            "Markdown conversion failed"
        }
    }
}
