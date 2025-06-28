//
//  Assignment.swift
//  Ogonek Swift
//
//  Created by Danila Volkov on 28.06.2025.
//

import Foundation

// MARK: Core

struct Assignment: Identifiable, Decodable, Hashable {
    let id: String
    let title: String
    let priority: UInt16
    let completed: Bool
    let dueDate: Date?
    let markdown: String
    let createdAt: Date
    let updatedAt: Date

    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case priority
        case completed
        case dueDate
        case markdown
        case createdAt
        case updatedAt
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: Error

extension AssignmentError: AppError {
    var shouldRetry: Bool {
        switch self {
        case .core(.networkUnavailable): return true
        case .taskNotFound: return false
        default: return false
        }
    }

    var userFacingMessage: String {
        switch self {
        case .missingRequiredFields:
            return "This Task has missing information"
        case .taskNotFound:
            return "Task not found"
        default:
            return "Internal Error Occured" // TODO: could be better!
        }
    }
}
