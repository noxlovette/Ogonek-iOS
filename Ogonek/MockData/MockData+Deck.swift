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
                front: "distant memory",
                id: "yPPHMaNa385TFg2nRVINz",
                mediaUrl: """
                https://docs-assets.developer.apple.com/published/\
                e4e79f1275f29c97f978794931fcae53/media-3262152%402x.png
                """
            ),
            Card(
                back: "a memory that stays with you for a long time",
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
                front: "painful memory is a really long long long sentence that the student will meow",
                id: "7wYXkSlqG7PTV61FwmGKh",
                mediaUrl: nil
            ),
            Card(
                back: "the ability to remember images or information in great detail",
                front: "photographic memory",
                id: "YLCs4XgFs0dky5idGT6Cm",
                mediaUrl: nil
            ),
            Card(
                back: "a memory that is unclear or not detailed",
                front: "vague memory",
                id: "FYtk1EFQU82YFNuvCpKJS",
                mediaUrl: nil
            ),
            Card(
                back: "a memory that is very clear and detailed",
                front: "vivid memory",
                id: "R5_wf24AkmNmUN70aOq_q",
                mediaUrl: nil
            ),
            Card(
                back: "to try to remember something from the past",
                front: "cast your mind back to",
                id: "T6UOaXiGCg1qOZnlncw3s",
                mediaUrl: nil
            ),
            Card(
                back: "to suddenly think of something",
                front: "come to mind",
                id: "axZXs2_lnqWChbZsKaCCq",
                mediaUrl: nil
            ),
            Card(
                back: "to help yourself or someone else remember something",
                front: "refresh your memory",
                id: "vYCO5_QoGh_N5Gl-CW6yT",
                mediaUrl: nil
            ),
            Card(
                back: "to forget something unintentionally",
                front: "slip your mind",
                id: "Ousj8n7i2NPR4LgwRkuaA",
                mediaUrl: nil
            ),
            Card(
                back: "to value and hold a memory dear",
                front: "treasure the memory of",
                id: "_smCQcx991eAkpvme4V5P",
                mediaUrl: nil
            ),
            Card(
                back: "to cause someone to remember something suddenly",
                front: "trigger a memory",
                id: "gvhkT-ONf35maFfYrnL1F",
                mediaUrl: nil
            ),
            Card(
                back: "to remember something in a not very clear or detailed way",
                front: "vaguely remember",
                id: "uRWN22HuPFCSYrKciu6Dg",
                mediaUrl: nil
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
            visibility: "assigned"
        )
    )

    static let decks = PaginatedDecks(
        data: [
            DeckSmall(
                assigneeName: "Alice Teacher",
                cardCount: 4,
                description: "Default Description",
                id: "VlHCKLoYEmrO5BYJqWBAp",
                isSubscribed: false,
                seen: false,
                title: "Unseen Deck",
                visibility: "private"
            ),
            DeckSmall(
                assigneeName: "Diana Learner",
                cardCount: 5,
                description: "Complex patterns and idioms in Rust programming",
                id: "0mNE0QOytmJAc0GsFJq6E",
                isSubscribed: true,
                seen: true,
                title: "Advanced Rust Patterns",
                visibility: "assigned"
            ),
            DeckSmall(
                assigneeName: "Charlie Student",
                cardCount: 8,
                description: "Essential Rust terms and concepts for beginners",
                id: "j8JiEp5K5zwYVetixBFiU",
                isSubscribed: false,
                seen: true,
                title: "Rust Vocabulary",
                visibility: "private"
            )
        ],
        page: 1,
        perPage: 50
    )

    static let cardProgress = [
        CardProgress(
            back: "a memory from a long time ago",
            front: "distant memory",
            id: "t-oebOC6El-HA3ieMfbgJ",
        ),
        CardProgress(
            back: "to value and hold a memory dear",
            front: "treasure the memory of",
            id: "jEvsCyiGr5nkucHKb2due",
        ),
        CardProgress(
            back: "a memory that is unclear or not detailed",
            front: "vague memory",
            id: "lZ9CsDZVqbYE4q5f3ATPd",
        ),
        CardProgress(
            back: "to help yourself or someone else remember something",
            front: "refresh your memory",
            id: "XsBE7s9Q-Y9a_JBtlS-JN",
        ),
        CardProgress(
            back: "to cause someone to remember something suddenly",
            front: "trigger a memory",
            id: "fewuiofhewjh3r333p"
        ),
        CardProgress(
            back: "to suddenly think of something",
            front: "come to mind",
            id: "uNoxn0dhZMHk7Rh1FSApo",
        ),
        CardProgress(
            back: "to remember something in a not very clear or detailed way",
            front: "vaguely remember",
            id: "vH5Rpxp0hDosB0ASFGXdq",
        ),
        CardProgress(
            back: "a memory that causes emotional pain or distress",
            front: "painful memory",
            id: "hs9tIR4iR_mWKz9KpjlVK",
        ),
        CardProgress(
            back: "a memory that is very clear and detailed",
            front: "vivid memory",
            id: "VzXhUroFFqj32YHZlLsth",
        )
    ]
}

