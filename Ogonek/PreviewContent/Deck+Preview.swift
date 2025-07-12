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
            count: 12,
            isSubscribed: true,
            createdAt: Date.distantPast
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
                count: 20,
                isSubscribed: true,
                createdAt: Date()
            ),
            Deck(
                id: "deck002",
                name: "iOS Architecture",
                description: "MVC; MVVM; VIPER",
                visibility: "private",
                count: 15,
                isSubscribed: false,
                createdAt: Calendar.current.date(byAdding: .day, value: -10, to: Date())!
            ),
            Deck(
                id: "deck003",
                name: "Design Patterns",
                description: "Singleton; Observer; Factory",
                visibility: "public",
                count: 18,
                isSubscribed: true,
                createdAt: Calendar.current.date(byAdding: .month, value: -2, to: Date())!
            ),
            Deck(
                id: "deck004",
                name: "Algorithms",
                description: "Sorting; Searching; Graphs",
                visibility: "unlisted",
                count: 30,
                isSubscribed: false,
                createdAt: Calendar.current.date(byAdding: .year, value: -1, to: Date())!
            ),
            Deck.preview,
        ]
    }
}
