//
//  Assignment+Preview.swift
//  Ogonek
//
//  Created by Danila Volkov on 28.06.2025.
//

import Foundation

extension Assignment {
    static var preview: Assignment {
        let task = Assignment(
            id: "wzozO4mi3TfRit5aQbrGp",
            title: "Task 1",
            priority: 3,
            completed: false,
            dueDate: Date.distantFuture,
            markdown: "# Just a test \n[link](https://google.com)",
            createdAt: Date.distantPast,
            updatedAt: Date.now
        )

        return task
    }

    static var previewSet: [Assignment] {
        [
            Assignment(
                id: "task001",
                title: "Read Swift Documentation",
                priority: 2,
                completed: false,
                dueDate: Calendar.current.date(byAdding: .day, value: 2, to: Date())!,
                markdown: "## Reading Plan\n- Variables\n- Optionals\n- Closures",
                createdAt: Calendar.current.date(byAdding: .day, value: -1, to: Date())!,
                updatedAt: Date.now
            ),
            Assignment(
                id: "task002",
                title: "Fix Login Bug",
                priority: 1,
                completed: true,
                dueDate: Calendar.current.date(byAdding: .day, value: -5, to: Date())!,
                markdown: "**Resolved:** Issue with `AuthManager` initialization.",
                createdAt: Calendar.current.date(byAdding: .day, value: -10, to: Date())!,
                updatedAt: Calendar.current.date(byAdding: .day, value: -4, to: Date())!
            ),
            Assignment(
                id: "task003",
                title: "Prepare App Store Screenshots",
                priority: 3,
                completed: false,
                dueDate: Calendar.current.date(byAdding: .day, value: 7, to: Date())!,
                markdown: "- Use latest build\n- Include dark mode shots\n- Update captions",
                createdAt: Calendar.current.date(byAdding: .day, value: -2, to: Date())!,
                updatedAt: Date.now
            ),
            Assignment(
                id: "task004",
                title: "Refactor ViewModel Layer",
                priority: 2,
                completed: false,
                dueDate: Calendar.current.date(byAdding: .day, value: 14, to: Date())!,
                markdown: "### Goals\n- Reduce boilerplate\n- Improve testability",
                createdAt: Date(),
                updatedAt: Date()
            ),
            Assignment.preview,
        ]
    }
}
