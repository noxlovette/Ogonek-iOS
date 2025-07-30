//
//  Deck+Preview.swift
//  Ogonek
//
//  Created by Danila Volkov on 30.07.2025.
//

import Foundation

extension DeckSmall {
    static var previewSet: [DeckSmall] {
        [
            DeckSmall(
                assigneeName: "Alice Teacher",
                description: "Default Description",
                id: "VlHCKLoYEmrO5BYJqWBAp",
                isSubscribed: false,
                name: "Default Deck",
                seen: true,
                visibility: "private"
            ),
            DeckSmall(
                assigneeName: "Diana Learner",
                description: "Complex patterns and idioms in Rust programming",
                id: "0mNE0QOytmJAc0GsFJq6E",
                isSubscribed: true,
                name: "Advanced Rust Patterns",
                seen: true,
                visibility: "assigned"
            ),
            DeckSmall(
                assigneeName: "Charlie Student",
                description: "Essential Rust terms and concepts for beginners",
                id: "j8JiEp5K5zwYVetixBFiU",
                isSubscribed: false,
                name: "Rust Vocabulary",
                seen: true,
                visibility: "private"
            )
        ]
    }
}

extension DeckWithCards {
    static var preview: DeckWithCards {
        DeckWithCards(
            cards: [
                Card(
                    back: "a memory from a long time ago",
                    createdAt: ISO8601DateFormatter().date(from: "2025-07-18T08:36:49.127396Z") ?? Date(),
                    deckId: "0mNE0QOytmJAc0GsFJq6E",
                    front: "distant memory",
                    id: "yPPHMaNa385TFg2nRVINz",
                    mediaUrl: nil
                ),
                Card(
                    back: "a memory that stays with you for a long time",
                    createdAt: ISO8601DateFormatter().date(from: "2025-07-18T08:36:49.127396Z") ?? Date(),
                    deckId: "0mNE0QOytmJAc0GsFJq6E",
                    front: "lasting memory",
                    id: "8E58QbmXUcIqQgSIBrThL",
                    mediaUrl: nil
                ),
                Card(
                    back: "a memory that causes emotional pain or distress",
                    createdAt: ISO8601DateFormatter().date(from: "2025-07-18T08:36:49.127396Z") ?? Date(),
                    deckId: "0mNE0QOytmJAc0GsFJq6E",
                    front: "painful memory",
                    id: "7wYXkSlqG7PTV61FwmGKh",
                    mediaUrl: nil
                ),
                Card(
                    back: "the ability to remember images or information in great detail",
                    createdAt: ISO8601DateFormatter().date(from: "2025-07-18T08:36:49.127396Z") ?? Date(),
                    deckId: "0mNE0QOytmJAc0GsFJq6E",
                    front: "photographic memory",
                    id: "YLCs4XgFs0dky5idGT6Cm",
                    mediaUrl: nil
                ),
                Card(
                    back: "a memory that is unclear or not detailed",
                    createdAt: ISO8601DateFormatter().date(from: "2025-07-18T08:36:49.127396Z") ?? Date(),
                    deckId: "0mNE0QOytmJAc0GsFJq6E",
                    front: "vague memory",
                    id: "FYtk1EFQU82YFNuvCpKJS",
                    mediaUrl: nil
                ),
                Card(
                    back: "a memory that is very clear and detailed",
                    createdAt: ISO8601DateFormatter().date(from: "2025-07-18T08:36:49.127396Z") ?? Date(),
                    deckId: "0mNE0QOytmJAc0GsFJq6E",
                    front: "vivid memory",
                    id: "R5_wf24AkmNmUN70aOq_q",
                    mediaUrl: nil
                ),
                Card(
                    back: "to try to remember something from the past",
                    createdAt: ISO8601DateFormatter().date(from: "2025-07-18T08:36:49.127396Z") ?? Date(),
                    deckId: "0mNE0QOytmJAc0GsFJq6E",
                    front: "cast your mind back to",
                    id: "T6UOaXiGCg1qOZnlncw3s",
                    mediaUrl: nil
                ),
                Card(
                    back: "to suddenly think of something",
                    createdAt: ISO8601DateFormatter().date(from: "2025-07-18T08:36:49.127396Z") ?? Date(),
                    deckId: "0mNE0QOytmJAc0GsFJq6E",
                    front: "come to mind",
                    id: "axZXs2_lnqWChbZsKaCCq",
                    mediaUrl: nil
                ),
                Card(
                    back: "to help yourself or someone else remember something",
                    createdAt: ISO8601DateFormatter().date(from: "2025-07-18T08:36:49.127396Z") ?? Date(),
                    deckId: "0mNE0QOytmJAc0GsFJq6E",
                    front: "refresh your memory",
                    id: "vYCO5_QoGh_N5Gl-CW6yT",
                    mediaUrl: nil
                ),
                Card(
                    back: "to forget something unintentionally",
                    createdAt: ISO8601DateFormatter().date(from: "2025-07-18T08:36:49.127396Z") ?? Date(),
                    deckId: "0mNE0QOytmJAc0GsFJq6E",
                    front: "slip your mind",
                    id: "Ousj8n7i2NPR4LgwRkuaA",
                    mediaUrl: nil
                ),
                Card(
                    back: "to value and hold a memory dear",
                    createdAt: ISO8601DateFormatter().date(from: "2025-07-18T08:36:49.127396Z") ?? Date(),
                    deckId: "0mNE0QOytmJAc0GsFJq6E",
                    front: "treasure the memory of",
                    id: "_smCQcx991eAkpvme4V5P",
                    mediaUrl: nil
                ),
                Card(
                    back: "to cause someone to remember something suddenly",
                    createdAt: ISO8601DateFormatter().date(from: "2025-07-18T08:36:49.127396Z") ?? Date(),
                    deckId: "0mNE0QOytmJAc0GsFJq6E",
                    front: "trigger a memory",
                    id: "gvhkT-ONf35maFfYrnL1F",
                    mediaUrl: nil
                ),
                Card(
                    back: "to remember something in a not very clear or detailed way",
                    createdAt: ISO8601DateFormatter().date(from: "2025-07-18T08:36:49.127396Z") ?? Date(),
                    deckId: "0mNE0QOytmJAc0GsFJq6E",
                    front: "vaguely remember",
                    id: "uRWN22HuPFCSYrKciu6Dg",
                    mediaUrl: nil
                )
            ],
            deck: Deck(
                assignee: "dev_student2_FFrb-e1V",
                createdAt: ISO8601DateFormatter().date(from: "2025-07-18T08:27:14.543237Z") ?? Date(),
                createdBy: "dev_teacher1_sDkwvkSa",
                description: "Complex patterns and idioms in Rust programming",
                id: "0mNE0QOytmJAc0GsFJq6E",
                isSubscribed: true,
                name: "Advanced Rust Patterns",
                visibility: "assigned"
            ),
            isSubscribed: true
        )
    }
}
