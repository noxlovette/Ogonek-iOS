//
//  MockData+Task.swift
//  Ogonek
//
//  Created by Danila Volkov on 07.08.2025.
//

import Foundation

extension MockData {
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
            dueDate: Date(timeIntervalSinceNow: +5000),
            id: "Bzgbqk11luSf32OB48pQA",
            markdown: """
            # Complete Ownership Exercise

            ## Overview
            This exercise will help you understand Rust's ownership system,
            which is one of the most important concepts in the language.

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
            title: "Ownership Exercise",
            updatedAt: Date(timeIntervalSinceNow: -1000),
        ),
    )

    static let tasks = PaginatedTasks(
        data: [
            TaskSmall(
                assigneeName: "Charlie Student",
                completed: false,
                dueDate: Date(timeIntervalSinceNow: -1000),
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
