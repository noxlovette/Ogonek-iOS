//
//  MockData+Deck.swift
//  Ogonek
//
//  Created by Danila Volkov on 07.08.2025.
//

import Foundation

extension MockData {
    static let deck = DeckWithCards(
        cards: [
            Card(
                back: "a memory from a long time ago",
                createdAt: ISO8601DateFormatter().date(from: "2025-07-18T08:36:49.127396Z") ?? Date(),
                deckId: "0mNE0QOytmJAc0GsFJq6E",
                front: "distant memory",
                id: "yPPHMaNa385TFg2nRVINz",
                mediaUrl: """
        https://docs-assets.developer.apple.com/published/\
        e4e79f1275f29c97f978794931fcae53/media-3262152%402x.png
        """
            ),
            Card(
                back: "a memory that stays with you for a long time",
                createdAt: ISO8601DateFormatter().date(from: "2025-07-18T08:36:49.127396Z") ?? Date(),
                deckId: "0mNE0QOytmJAc0GsFJq6E",
                front: "lasting memory",
                id: "8E58QbmXUcIqQgSIBrThL",
                mediaUrl: """
        https://static.wikia.nocookie.net/hello_world/images/3/3e/\
        414a8ef0-f3bb-11e9-bdfc-d4aea2070a0f.jpg/revision/latest/\
        thumbnail/width/360/height/360?cb=20200515011426
        """
            ),

            Card(
                back: "a memory that causes emotional pain or distress",
                createdAt: ISO8601DateFormatter().date(from: "2025-07-18T08:36:49.127396Z") ?? Date(),
                deckId: "0mNE0QOytmJAc0GsFJq6E",
                front: "painful memory is a really long long long sentence that the student will meow",
                id: "7wYXkSlqG7PTV61FwmGKh",
                mediaUrl: nil,
            ),
            Card(
                back: "the ability to remember images or information in great detail",
                createdAt: ISO8601DateFormatter().date(from: "2025-07-18T08:36:49.127396Z") ?? Date(),
                deckId: "0mNE0QOytmJAc0GsFJq6E",
                front: "photographic memory",
                id: "YLCs4XgFs0dky5idGT6Cm",
                mediaUrl: nil,
            ),
            Card(
                back: "a memory that is unclear or not detailed",
                createdAt: ISO8601DateFormatter().date(from: "2025-07-18T08:36:49.127396Z") ?? Date(),
                deckId: "0mNE0QOytmJAc0GsFJq6E",
                front: "vague memory",
                id: "FYtk1EFQU82YFNuvCpKJS",
                mediaUrl: nil,
            ),
            Card(
                back: "a memory that is very clear and detailed",
                createdAt: ISO8601DateFormatter().date(from: "2025-07-18T08:36:49.127396Z") ?? Date(),
                deckId: "0mNE0QOytmJAc0GsFJq6E",
                front: "vivid memory",
                id: "R5_wf24AkmNmUN70aOq_q",
                mediaUrl: nil,
            ),
            Card(
                back: "to try to remember something from the past",
                createdAt: ISO8601DateFormatter().date(from: "2025-07-18T08:36:49.127396Z") ?? Date(),
                deckId: "0mNE0QOytmJAc0GsFJq6E",
                front: "cast your mind back to",
                id: "T6UOaXiGCg1qOZnlncw3s",
                mediaUrl: nil,
            ),
            Card(
                back: "to suddenly think of something",
                createdAt: ISO8601DateFormatter().date(from: "2025-07-18T08:36:49.127396Z") ?? Date(),
                deckId: "0mNE0QOytmJAc0GsFJq6E",
                front: "come to mind",
                id: "axZXs2_lnqWChbZsKaCCq",
                mediaUrl: nil,
            ),
            Card(
                back: "to help yourself or someone else remember something",
                createdAt: ISO8601DateFormatter().date(from: "2025-07-18T08:36:49.127396Z") ?? Date(),
                deckId: "0mNE0QOytmJAc0GsFJq6E",
                front: "refresh your memory",
                id: "vYCO5_QoGh_N5Gl-CW6yT",
                mediaUrl: nil,
            ),
            Card(
                back: "to forget something unintentionally",
                createdAt: ISO8601DateFormatter().date(from: "2025-07-18T08:36:49.127396Z") ?? Date(),
                deckId: "0mNE0QOytmJAc0GsFJq6E",
                front: "slip your mind",
                id: "Ousj8n7i2NPR4LgwRkuaA",
                mediaUrl: nil,
            ),
            Card(
                back: "to value and hold a memory dear",
                createdAt: ISO8601DateFormatter().date(from: "2025-07-18T08:36:49.127396Z") ?? Date(),
                deckId: "0mNE0QOytmJAc0GsFJq6E",
                front: "treasure the memory of",
                id: "_smCQcx991eAkpvme4V5P",
                mediaUrl: nil,
            ),
            Card(
                back: "to cause someone to remember something suddenly",
                createdAt: ISO8601DateFormatter().date(from: "2025-07-18T08:36:49.127396Z") ?? Date(),
                deckId: "0mNE0QOytmJAc0GsFJq6E",
                front: "trigger a memory",
                id: "gvhkT-ONf35maFfYrnL1F",
                mediaUrl: nil,
            ),
            Card(
                back: "to remember something in a not very clear or detailed way",
                createdAt: ISO8601DateFormatter().date(from: "2025-07-18T08:36:49.127396Z") ?? Date(),
                deckId: "0mNE0QOytmJAc0GsFJq6E",
                front: "vaguely remember",
                id: "uRWN22HuPFCSYrKciu6Dg",
                mediaUrl: nil,
            )
        ],
        deck: Deck(
            assignee: "dev_student2_FFrb-e1V",
            cardCount: 10,
            createdAt: ISO8601DateFormatter().date(from: "2025-07-18T08:27:14.543237Z") ?? Date(),
            createdBy: "dev_teacher1_sDkwvkSa",
            description: "Complex patterns and idioms in Rust programming",
            id: "0mNE0QOytmJAc0GsFJq6E",
            isSubscribed: true,
            title: "Advanced Rust Patterns",
            visibility: "assigned",
        ),
    )

    static let decks = PaginatedDecks(
        data: [
            DeckSmall(
                assigneeName: "Alice Teacher", cardCount: 4,
                description: "Default Description",
                id: "VlHCKLoYEmrO5BYJqWBAp",
                isSubscribed: false,
                seen: false, title: "Unseen Deck",
                visibility: "private",
            ),
            DeckSmall(
                assigneeName: "Diana Learner",
                cardCount: 5,
                description: "Complex patterns and idioms in Rust programming",
                id: "0mNE0QOytmJAc0GsFJq6E",
                isSubscribed: true,
                seen: true, title: "Advanced Rust Patterns",
                visibility: "assigned",
            ),
            DeckSmall(
                assigneeName: "Charlie Student",
                cardCount: 8,
                description: "Essential Rust terms and concepts for beginners",
                id: "j8JiEp5K5zwYVetixBFiU",
                isSubscribed: false,
                seen: true, title: "Rust Vocabulary",
                visibility: "private",
            )
        ],
        page: 1,
        perPage: 50,
    )

    static let cardProgress = [
        CardProgress(
            back: "a memory from a long time ago",
            cardId: "yPPHMaNa385TFg2nRVINz",
            dueDate: ISO8601DateFormatter().date(from: "2025-07-26T08:22:37.624459Z"),
            easeFactor: 2.5,
            front: "distant memory",
            id: "t-oebOC6El-HA3ieMfbgJ",
            interval: 1,
            lastReviewed: ISO8601DateFormatter().date(from: "2025-07-25T08:22:37.624457Z"),
            reviewCount: 1,
            userId: "dev_teacher1_sDkwvkSa",
        ),
        CardProgress(
            back: "to value and hold a memory dear",
            cardId: "_smCQcx991eAkpvme4V5P",
            dueDate: ISO8601DateFormatter().date(from: "2025-07-26T08:22:39.509595Z"),
            easeFactor: 2.36,
            front: "treasure the memory of",
            id: "jEvsCyiGr5nkucHKb2due",
            interval: 1,
            lastReviewed: ISO8601DateFormatter().date(from: "2025-07-25T08:22:39.509593Z"),
            mediaUrl: nil,
            reviewCount: 1,
            userId: "dev_teacher1_sDkwvkSa",
        ),
        CardProgress(
            back: "a memory that is unclear or not detailed",
            cardId: "FYtk1EFQU82YFNuvCpKJS",
            dueDate: ISO8601DateFormatter().date(from: "2025-07-26T08:22:40.218829Z"),
            easeFactor: 2.5,
            front: "vague memory",
            id: "lZ9CsDZVqbYE4q5f3ATPd",
            interval: 1,
            lastReviewed: ISO8601DateFormatter().date(from: "2025-07-25T08:22:40.218828Z"),
            mediaUrl: nil,
            reviewCount: 1,
            userId: "dev_teacher1_sDkwvkSa",
        ),
        CardProgress(
            back: "to help yourself or someone else remember something",
            cardId: "vYCO5_QoGh_N5Gl-CW6yT",
            dueDate: ISO8601DateFormatter().date(from: "2025-07-26T08:22:41.030269Z"),
            easeFactor: 2.6,
            front: "refresh your memory",
            id: "XsBE7s9Q-Y9a_JBtlS-JN",
            interval: 1,
            lastReviewed: ISO8601DateFormatter().date(from: "2025-07-25T08:22:41.030268Z"),
            mediaUrl: nil,
            reviewCount: 1,
            userId: "dev_teacher1_sDkwvkSa",
        ),
        CardProgress(
            back: "to cause someone to remember something suddenly",
            cardId: "gvhkT-ONf35maFfYrnL1F",
            dueDate: ISO8601DateFormatter().date(from: "2025-07-26T08:22:42.279349Z"),
            easeFactor: 2.36,
            front: "trigger a memory",
            id: "khgqKXKEmvzjGFtZfN0XR",
            interval: 1,
            lastReviewed: ISO8601DateFormatter().date(from: "2025-07-25T08:22:42.279347Z"),
            mediaUrl: nil,
            reviewCount: 1,
            userId: "dev_teacher1_sDkwvkSa",
        ),
        CardProgress(
            back: "to suddenly think of something",
            cardId: "axZXs2_lnqWChbZsKaCCq",
            dueDate: ISO8601DateFormatter().date(from: "2025-07-26T08:22:44.032433Z"),
            easeFactor: 2.36,
            front: "come to mind",
            id: "uNoxn0dhZMHk7Rh1FSApo",
            interval: 1,
            lastReviewed: ISO8601DateFormatter().date(from: "2025-07-25T08:22:44.032432Z"),
            mediaUrl: nil,
            reviewCount: 1,
            userId: "dev_teacher1_sDkwvkSa",
        ),
        CardProgress(
            back: "to remember something in a not very clear or detailed way",
            cardId: "uRWN22HuPFCSYrKciu6Dg",
            dueDate: ISO8601DateFormatter().date(from: "2025-07-26T08:22:44.731937Z"),
            easeFactor: 2.5,
            front: "vaguely remember",
            id: "vH5Rpxp0hDosB0ASFGXdq",
            interval: 1,
            lastReviewed: ISO8601DateFormatter().date(from: "2025-07-25T08:22:44.731936Z"),
            mediaUrl: nil,
            reviewCount: 1,
            userId: "dev_teacher1_sDkwvkSa",
        ),
        CardProgress(
            back: "a memory that causes emotional pain or distress",
            cardId: "7wYXkSlqG7PTV61FwmGKh",
            dueDate: ISO8601DateFormatter().date(from: "2025-07-26T08:22:47.659402Z"),
            easeFactor: 2.28,
            front: "painful memory",
            id: "hs9tIR4iR_mWKz9KpjlVK",
            interval: 1,
            lastReviewed: ISO8601DateFormatter().date(from: "2025-07-25T08:22:47.659401Z"),
            mediaUrl: nil,
            reviewCount: 1,
            userId: "dev_teacher1_sDkwvkSa",
        ),
        CardProgress(
            back: "a memory that is very clear and detailed",
            cardId: "R5_wf24AkmNmUN70aOq_q",
            dueDate: ISO8601DateFormatter().date(from: "2025-07-26T08:22:47.659402Z"),
            easeFactor: 1.6399999999999997,
            front: "vivid memory",
            id: "VzXhUroFFqj32YHZlLsth",
            interval: 1,
            lastReviewed: ISO8601DateFormatter().date(from: "2025-07-25T08:22:56.932583Z"),
            mediaUrl: nil,
            reviewCount: 1,
            userId: "dev_teacher1_sDkwvkSa",
        )
    ]
}
