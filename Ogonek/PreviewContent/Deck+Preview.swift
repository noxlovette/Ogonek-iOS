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
            id: "wzozO4mi3TfRit5aQbrGp",
            name: "Deck 1",
            description: "Meow; Meow2; Meow?",
            visibility: "public",
            seen: true,
            assigneeName: "Alice",
            isSubscribed: true
        )

        return deck
    }

    static var previewSet: [Deck] {
        [
            Deck(
                id: "deck001",
                name: "Swift Basics",
                description: "Variables; Constants; Control Flow",
                visibility: "public",
                seen: true,
                assigneeName: "Bob",
                isSubscribed: true
            ),
            Deck(
                id: "deck002",
                name: "iOS Architecture",
                description: "MVC; MVVM; VIPER",
                visibility: "private",
                seen: false,
                assigneeName: "Carol",
                isSubscribed: false
            ),
            Deck(
                id: "deck003",
                name: "Design Patterns",
                description: "Singleton; Observer; Factory",
                visibility: "public",
                seen: nil,
                assigneeName: nil,
                isSubscribed: true
            ),
            Deck(
                id: "deck004",
                name: "Algorithms",
                description: "Sorting; Searching; Graphs",
                visibility: "unlisted",
                seen: false,
                assigneeName: "Dave",
                isSubscribed: false
            ),
            Deck.preview,
        ]
    }
}
