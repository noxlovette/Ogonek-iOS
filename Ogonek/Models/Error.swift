//
//  Error.swift
//  Ogonek
//
//  Created by Danila Volkov on 26.06.2025.
//

import Foundation

// Core network/system errors

enum CoreError: Error {
    case networkUnavailable
    case serverError(Int)
    case decodingFailed
    case unauthorized
    case unexpectedError(Error)
}

enum LessonError: Error {
    case missingRequiredFields
    case lessonNotFound
    case invalidLessonType
    case core(CoreError)
}

enum AssignmentError: Error {
    case missingRequiredFields
    case taskNotFound
    case core(CoreError)
}

enum ProfileError: Error {
    case invalidEmail
    case passwordTooWeak
    case profileNotFound
    case core(CoreError)
}

enum DeckError: Error {
    case missingRequiredFields
    case deckNotFound
    case core(CoreError)
}

protocol AppError: LocalizedError {
    var userFacingMessage: String { get }
    var shouldRetry: Bool { get }
}
