//
//  LessonError.swift
//  Ogonek Swift
//
//  Created by Danila Volkov on 29.04.2025.
//

import Foundation

enum LessonError: Error {
    case missingData
    case networkError
    case unexpectedError(error: Error)
}

extension LessonError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .missingData:
            return NSLocalizedString(
                "Found and will discard a quake missing a valid code, magnitude, place, or time.",
                comment: "")
        case .networkError:
            return NSLocalizedString("Error fetching lesson data over the network.", comment: "")
        case .unexpectedError(let error):
            return NSLocalizedString(
                "Received unexpected error. \(error.localizedDescription)", comment: "")
        }
    }
}
