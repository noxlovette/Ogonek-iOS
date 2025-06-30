//
//  Deck+Preview.swift
//  Ogonek
//
//  Created by Danila Volkov on 28.06.2025.
//

import Foundation

extension Deck {
    static var preview: Deck {
        let deck = Deck(
            id: "wzozO4mi3TfRit5aQbrGp", name: "Task 1", description: "Meow; Meow2; Meow?", visibility: "public", count: 12, isSubscribed: true, createdAt: Date.distantPast
        )

        return deck
    }
}
