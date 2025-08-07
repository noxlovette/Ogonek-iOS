//
//  MockData+Lesson.swift
//  Ogonek
//
//  Created by Danila Volkov on 07.08.2025.
//

import Foundation

extension MockData {
    static let lesson1 = Lesson(
        assignee: "Bc3JW7pm1Zh450ty95fAI",
        assigneeName: "Performance review",
        createdAt: Date(timeIntervalSinceNow: -1000),
        createdBy: "Svatko 22.12.2024",
        id: "lesson1",
        markdown: """
        # Performance
        ## Strengths
        - urgently - good vocabulary
        - the purpose PDF - that was perfecis not an adjective! it's a verb!
        """,
        title: "1234567890",
        topic: "Weak",
        updatedAt: Date(),
    )

    static let paginatedLessons = PaginatedLessons(
        data: [
            LessonSmall(
                assigneeName: "Charlie Student",
                createdAt: ISO8601DateFormatter().date(from: "2025-07-25T08:26:31.980596Z") ?? Date(),
                id: "etxAsCsyVpJF-_fpW5bDB",
                seen: false,
                title: "Unseen",
                topic: "Hidden Operations",
            ),
            LessonSmall(
                assigneeName: "Alice Teacher",
                createdAt: ISO8601DateFormatter().date(from: "2025-07-25T08:18:41.907449Z") ?? Date(),
                id: "b5wVIcYGFmgow6blH_T0j",
                seen: true,
                title: "Default Title",
                topic: "Default Topic",
            ),
            LessonSmall(
                assigneeName: "Alice Teacher",
                createdAt: ISO8601DateFormatter().date(from: "2025-07-24T13:14:26.051558Z") ?? Date(),
                id: "TOtmT_eHWsHYXnpDlaqUI",
                seen: true,
                title: "Changed",
                topic: "Default Topic",
            ),
            LessonSmall(
                assigneeName: "Charlie Student",
                createdAt: ISO8601DateFormatter().date(from: "2025-07-18T08:27:14.533777Z") ?? Date(),
                id: "vWSUUOKC4sxE8xKYjHngj",
                seen: true,
                title: "Rust Basics",
                topic: "Ownership and Borrowing",
            )
        ],
        page: 1,
        perPage: 50,
        total: 4,
    )
}
