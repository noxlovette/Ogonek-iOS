//
//  Lesson.swift
//  Ogonek Swift
//
//  Created by Danila Volkov on 29.04.2025.
//

import Foundation


// MARK: Core
struct Lesson: Identifiable, Decodable {
    let id: String
    let title: String
    let topic: String
    let markdown: String
    let createdAt: Date
    let updatedAt: Date

    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case topic
        case markdown
        case createdAt
        case updatedAt
    }
}


// MARK: Error

extension LessonError: AppError {
    var shouldRetry: Bool {
        switch self {
        case .core(.networkUnavailable): return true
        case .lessonNotFound: return false
        default: return false
        }
    }

    var userFacingMessage: String {
        switch self {
        case .missingRequiredFields:
            return "This lesson has missing information"
        case .lessonNotFound:
            return "Lesson not found"
        default:
            return "Internal Error Occured" // TODO: could be better!
        }


    }
}
