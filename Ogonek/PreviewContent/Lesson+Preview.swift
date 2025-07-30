//
//  Lesson+Preview.swift
//  Ogonek
//
//  Created by Danila Volkov on 29.04.2025.
//

import Foundation

extension Lesson {
    static var preview: Lesson {
        let lesson = Lesson(
            assignee: "Bc3JW7pm1Zh450ty95fAI",
            assigneeName: "Performance review",
            createdAt: Date(timeIntervalSinceNow: -1000),
            createdBy: "Svatko 22.12.2024",
            id: "lesson1",
            markdown: "# Performance\n## Strengths\n- urgently - good vocabulary\n- the purpose PDF - that was perfect\n- great vocabulary work with extreme adjectives\n- workplace - even though you said 'jobplaces', it's great that you attempt to mix words! this is very English\n## Weaknesses\n- please do not use language models or translators to do **all** your writing work. it's a good idea to translate or ask them to translate **some** fixed expressions, though\n\n---\n# Input\n## Pronunciation\n- urgently\n- read in the past\n## Grammar\n- I don't know where her pictures are\n- you cannot use continuous tenses with frequencies\n- -self - the object is the same as the subject \n## Vocabulary\n- something stops working\n- are you agree - doesn't exist. 'agree' is not an adjective! it's a verb!",
            title: "1234567890",
            topic: "Weak",
            updatedAt: Date()
        )
        return lesson
    }
}

extension PaginatedLessons {
    static var preview: PaginatedLessons {
        PaginatedLessons(
            data: [
                PaginatedLessons.DataPayloadPayload(
                    assigneeName: "Charlie Student",
                    createdAt: ISO8601DateFormatter().date(from: "2025-07-25T08:26:31.980596Z") ?? Date(),
                    id: "etxAsCsyVpJF-_fpW5bDB",
                    seen: true,
                    title: "Default Title",
                    topic: "Default Topicfefefe"
                ),
                PaginatedLessons.DataPayloadPayload(
                    assigneeName: "Alice Teacher",
                    createdAt: ISO8601DateFormatter().date(from: "2025-07-25T08:18:41.907449Z") ?? Date(),
                    id: "b5wVIcYGFmgow6blH_T0j",
                    seen: true,
                    title: "Default Title",
                    topic: "Default Topic"
                ),
                PaginatedLessons.DataPayloadPayload(
                    assigneeName: "Alice Teacher",
                    createdAt: ISO8601DateFormatter().date(from: "2025-07-24T13:14:26.051558Z") ?? Date(),
                    id: "TOtmT_eHWsHYXnpDlaqUI",
                    seen: true,
                    title: "Changed",
                    topic: "Default Topic"
                ),
                PaginatedLessons.DataPayloadPayload(
                    assigneeName: "Charlie Student",
                    createdAt: ISO8601DateFormatter().date(from: "2025-07-18T08:27:14.533777Z") ?? Date(),
                    id: "vWSUUOKC4sxE8xKYjHngj",
                    seen: true,
                    title: "Rust Basics",
                    topic: "Ownership and Borrowing"
                )
            ],
            page: 1,
            perPage: 50,
            total: 4
        )
    }
}
