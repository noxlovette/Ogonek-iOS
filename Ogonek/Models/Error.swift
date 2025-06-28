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

// Domain-specific errors that compose CoreError
enum LessonError: Error {
    case missingRequiredFields
    case lessonNotFound
    case invalidLessonType
    case core(CoreError) // Wrap core errors
}

enum AssignmentError: Error {
    case missingRequiredFields
    case taskNotFound
    case core(CoreError) // Wrap core errors
}

enum ProfileError: Error {
    case invalidEmail
    case passwordTooWeak
    case profileNotFound
    case core(CoreError)
}

protocol AppError: LocalizedError {
    var userFacingMessage: String { get }
    var shouldRetry: Bool { get }
}
