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
    case unknownError

    var errorDescription: String? {
        switch self {
        case .unauthorized:
            return "Authentication required"
        case let .networkError(error):
            return "Network error: \(error.localizedDescription)"
        case let .decodingError(error):
            return "Data parsing error: \(error.localizedDescription)"
        case let .serverError(statusCode):
            return "Server error (status: \(statusCode))"
        case .unknownError:
            return "An unknown error occurred"
        case .notFound:
            return "Resource not found"
        }
    }
}
