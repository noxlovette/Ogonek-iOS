//
//  Flashcards.swift
//  Ogonek Swift
//
//  Created by Danila Volkov on 28.06.2025.
//

import Foundation

// MARK: Deck
struct Deck: Identifiable, Decodable, Hashable {
    let id: String
    let name: String
    let description: String?
    let visibility: String
    let seen: Bool?
    let assigneeName: String?
    let isSubscribed: Bool

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case visibility
        case seen
        case assigneeName
        case isSubscribed
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: Card
struct Card: Identifiable, Decodable, Hashable {
    let id: String
    let front: String
    let back: String
    let mediaUrl: String?
    let deckId: String
    let createdAt: Date

    private enum CodingKeys: String, CodingKey {
        case id
        case front
        case back
        case mediaUrl
        case deckId
        case createdAt
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: Errors

extension DeckError: AppError {
    var shouldRetry: Bool {
        switch self {
        case .core(.networkUnavailable): return true
        case .deckNotFound: return false
        default: return false
        }
    }

    var userFacingMessage: String {
        switch self {
        case .missingRequiredFields:
            return "This Task has missing information"
        case .deckNotFound:
            return "Task not found"
        default:
            return "Internal Error Occured" // TODO: could be better!
        }
    }
}
