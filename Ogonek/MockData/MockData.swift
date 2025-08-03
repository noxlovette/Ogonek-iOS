//
//  MockData.swift
//  Ogonek
//
//  Created by Danila Volkov on 31.07.2025.
//

import Foundation

enum MockData {
    // MARK: Lesson Data

    static let lesson1 = Lesson(
        assignee: "Bc3JW7pm1Zh450ty95fAI",
        assigneeName: "Performance review",
        createdAt: Date(timeIntervalSinceNow: -1000),
        createdBy: "Svatko 22.12.2024",
        id: "lesson1",
        markdown: "# Performance\n## Strengths\n- urgently - good vocabulary\n- the purpose PDF - that was perfecis not an adjective! it's a verb!",
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
                seen: true,
                title: "Default Title",
                topic: "Default Topicfefefe",
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
            ),
        ],
        page: 1,
        perPage: 50,
        total: 4,
    )

    // MARK: Deck Data

    static let deck = DeckWithCards(
        cards: [
            Card(
                back: "a memory from a long time ago",
                createdAt: ISO8601DateFormatter().date(from: "2025-07-18T08:36:49.127396Z") ?? Date(),
                deckId: "0mNE0QOytmJAc0GsFJq6E",
                front: "distant memory",
                id: "yPPHMaNa385TFg2nRVINz",
                mediaUrl: nil,
            ),
            Card(
                back: "a memory that stays with you for a long time",
                createdAt: ISO8601DateFormatter().date(from: "2025-07-18T08:36:49.127396Z") ?? Date(),
                deckId: "0mNE0QOytmJAc0GsFJq6E",
                front: "lasting memory",
                id: "8E58QbmXUcIqQgSIBrThL",
                mediaUrl: nil,
            ),
            Card(
                back: "a memory that causes emotional pain or distress",
                createdAt: ISO8601DateFormatter().date(from: "2025-07-18T08:36:49.127396Z") ?? Date(),
                deckId: "0mNE0QOytmJAc0GsFJq6E",
                front: "painful memory",
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
            ),
        ],
        deck: Deck(
            assignee: "dev_student2_FFrb-e1V",
            createdAt: ISO8601DateFormatter().date(from: "2025-07-18T08:27:14.543237Z") ?? Date(),
            createdBy: "dev_teacher1_sDkwvkSa",
            description: "Complex patterns and idioms in Rust programming",
            id: "0mNE0QOytmJAc0GsFJq6E",
            isSubscribed: true,
            name: "Advanced Rust Patterns",
            visibility: "assigned",
        ),
        isSubscribed: true,
    )

    static let decks = {
        [
            DeckSmall(
                assigneeName: "Alice Teacher",
                description: "Default Description",
                id: "VlHCKLoYEmrO5BYJqWBAp",
                isSubscribed: false,
                name: "Default Deck",
                seen: true,
                visibility: "private",
            ),
            DeckSmall(
                assigneeName: "Diana Learner",
                description: "Complex patterns and idioms in Rust programming",
                id: "0mNE0QOytmJAc0GsFJq6E",
                isSubscribed: true,
                name: "Advanced Rust Patterns",
                seen: true,
                visibility: "assigned",
            ),
            DeckSmall(
                assigneeName: "Charlie Student",
                description: "Essential Rust terms and concepts for beginners",
                id: "j8JiEp5K5zwYVetixBFiU",
                isSubscribed: false,
                name: "Rust Vocabulary",
                seen: true,
                visibility: "private",
            ),
        ]
    }

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
            mediaUrl: nil,
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
        ),
    ]

    // MARK: Task Data

    static let taskWithFiles = TaskWithFiles(
        files: [
            File(
                id: "file_ownership_starter",
                mimeType: "application/x-rust",
                name: "ownership_starter.rs",
                ownerId: "dev_teacher1_sDkwvkSa",
                s3Key: "tasks/KdqQcCb9jDz-AxQPBMJBo/ownership_starter.rs",
                size: 2048,
            ),
            File(
                id: "file_ownership_examples",
                mimeType: "text/markdown",
                name: "examples.md",
                ownerId: "dev_teacher1_sDkwvkSa",
                s3Key: "tasks/KdqQcCb9jDz-AxQPBMJBo/examples.md",
                size: 1024,
            ),
        ],
        task: TaskFull(
            assignee: "dev_teacher1_sDkwvkSa",
            assigneeName: "Alice Teacher",
            completed: false,
            createdAt: Date(timeIntervalSinceNow: -1000),
            createdBy: "dev_teacher1_sDkwvkSa",
            dueDate: nil,
            id: "Bzgbqk11luSf32OB48pQA",
            markdown: """
            # Complete Ownership Exercise

            ## Overview
            This exercise will help you understand Rust's ownership system, which is one of the most important concepts in the language.

            ## Tasks
            1. **Basic Ownership**: Write a function that takes ownership of a String and returns its length
            2. **Borrowing**: Create examples using `&` (immutable references) and `&mut` (mutable references)
            3. **Lifetimes**: Implement a function with explicit lifetime annotations

            ## Resources
            - [The Rust Book Chapter 4](https://doc.rust-lang.org/book/ch04-00-understanding-ownership.html)
            - [Rust by Example: Ownership](https://doc.rust-lang.org/rust-by-example/scope/move.html)

            ## Submission
            Upload your completed `.rs` file with all exercises implemented and commented.

            > **Note**: Make sure your code compiles without warnings!
            """,
            priority: 3,
            title: "Default Title",
            updatedAt: Date(timeIntervalSinceNow: -1000),
        ),
    )

    static let tasks = PaginatedTasks(
        data: [
            TaskSmall(
                assigneeName: "Charlie Student",
                completed: false,
                dueDate: ISO8601DateFormatter().date(from: "2025-07-25T08:27:14.462723Z"),
                id: "KdqQcCb9jDz-AxQPBMJBo",
                priority: 1,
                seen: true,
                title: "Complete Ownership Exercise",
            ),
            TaskSmall(
                assigneeName: "Diana Learner",
                completed: false,
                dueDate: ISO8601DateFormatter().date(from: "2025-07-30T23:59:59Z"),
                id: "5NjIP6emp6-HTQLacYTgw",
                priority: 2,
                seen: true,
                title: "Default Title",
            ),
            TaskSmall(
                assigneeName: "Diana Learner",
                completed: false,
                dueDate: ISO8601DateFormatter().date(from: "2025-08-01T08:27:14.462723Z"),
                id: "Z4sKrZiUDloYVbIcAiapb",
                priority: 1,
                seen: true,
                title: "Build Async Web Scraper",
            ),
            TaskSmall(
                assigneeName: "Alice Teacher",
                completed: false,
                dueDate: nil,
                id: "H5rYRaTVohG9u1AoBIo1y",
                priority: 1,
                seen: true,
                title: "Default Title",
            ),
            TaskSmall(
                assigneeName: "Alice Teacher",
                completed: false,
                dueDate: nil,
                id: "Bzgbqk11luSf32OB48pQA",
                priority: 3,
                seen: true,
                title: "Default Title",
            ),
            TaskSmall(
                assigneeName: "Alice Teacher",
                completed: false,
                dueDate: nil,
                id: "MwcjD6dZLJo0BpCDwqTrK",
                priority: 1,
                seen: true,
                title: "Default Title",
            ),
            TaskSmall(
                assigneeName: "Alice Teacher",
                completed: false,
                dueDate: nil,
                id: "70f7EBo2fPAk13a2PT4-I",
                priority: 1,
                seen: true,
                title: "New TaskSmall",
            ),
            TaskSmall(
                assigneeName: "Alice Teacher",
                completed: false,
                dueDate: nil,
                id: "x9xi83u9FYhvSc40FtoIj",
                priority: 1,
                seen: false,
                title: "Testing File Deletion",
            ),
        ],
        page: 1,
        perPage: 20,
        total: 9,
    )
}
