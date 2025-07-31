//
//  APIService+APIError.swift
//  Ogonek
//
//  Created by Danila Volkov on 31.07.2025.
//

import Foundation

public extension APIService {
    enum APIError: Error {
        case implicit(ErrorReason)
        case explicit(ErrorReason)

        public enum ErrorReason {
            // application internal error
            case authenticationMissing
            case badRequest
            case badResponse
            case requestThrottle

            // Server API error
            case ogonekAPIError(Ogonek.API.Error)
        }

        private var errorReason: ErrorReason {
            switch self {
            case let .implicit(errorReason): return errorReason
            case let .explicit(errorReason): return errorReason
            }
        }
    }
}

// MARK: - LocalizedError

extension APIService.APIError: LocalizedError {
    public var errorDescription: String? {
        switch errorReason {
        case .authenticationMissing: return "Fail to Authenticate"
        case .badRequest: return "Bad Request"
        case .badResponse: return "Bad Response"
        case .requestThrottle: return "Request Throttled"
        case let .ogonekAPIError(error):
            guard let responseError = error.ogonekError else {
                guard error.httpResponseStatus != .ok else {
                    return "Unknown Error"
                }
                return error.httpResponseStatus.reasonPhrase
            }

            return responseError.errorDescription
        }
    }

    public var failureReason: String? {
        switch errorReason {
        case .authenticationMissing: return "Account credential not found."
        case .badRequest: return "Request invalid."
        case .badResponse: return "Response invalid."
        case .requestThrottle: return "Request too frequency."
        case let .ogonekAPIError(error):
            guard let responseError = error.ogonekError else {
                return nil
            }
            return responseError.failureReason
        }
    }

    public var helpAnchor: String? {
        switch errorReason {
        case .authenticationMissing: return "Please request after authenticated."
        case .badRequest: return "Please try again."
        case .badResponse: return "Please try again."
        case .requestThrottle: return "Please try again later."
        case let .ogonekAPIError(error):
            guard let responseError = error.mastodonError else {
                return nil
            }
            return responseError.helpAnchor
        }
    }
}
