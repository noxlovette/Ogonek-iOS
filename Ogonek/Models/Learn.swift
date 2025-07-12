//
//  Learn.swift
//  Ogonek
//
//  Created by Danila Volkov on 12.07.2025.
//

import Foundation

struct CardProgress: Identifiable, Codable {
    let id: String
    let userId: String
    let cardId: String
    let reviewCount: Int
    let lastReviewed: Date?
    let dueDate: Date?
    let easeFactor: Double
    let interval: Int
    let front: String
    let back: String
    let mediaUrl: String?

    enum CodingKeys: String, CodingKey {
        case id, front, back
        case userId = "user_id"
        case cardId = "card_id"
        case reviewCount = "review_count"
        case lastReviewed = "last_reviewed"
        case dueDate = "due_date"
        case easeFactor = "ease_factor"
        case interval, mediaUrl = "media_url"
    }
}

