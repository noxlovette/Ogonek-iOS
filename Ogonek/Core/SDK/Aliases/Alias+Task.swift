//
//  Alias+Task.swift
//  Ogonek
//
//  Created by Danila Volkov on 31.07.2025.
//

import Foundation

typealias TaskWithFiles = Components.Schemas.TaskWithFilesResponse
typealias TaskUpdate = Components.Schemas.TaskUpdate
typealias TaskFull = Components.Schemas.TaskFull
typealias File = Components.Schemas.FileSmall

typealias TaskSmall = Components.Schemas.TaskSmall
extension TaskSmall: Identifiable {}

typealias PaginatedTasks = Components.Schemas.PaginatedTasks
typealias BadgeWrapperTasks = Components.Schemas.BadgeWrapperTasks

extension File: Identifiable {}

extension TaskWithFiles {
    static let placeholder = TaskWithFiles(
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
            )
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
            Loading...
            """,
            priority: 3,
            title: "Loading...",
            updatedAt: Date(timeIntervalSinceNow: -1000),
        ),
    )
}
