//
//  Task+Preview.swift
//  Ogonek
//
//  Created by Danila Volkov on 28.06.2025.
//

import Foundation

extension Task {
    static var preview: Task {
        let task = Task(
            assignee: "wzozO4mi3TfRit5aQbrGp",
            assigneeName: "Dmitry",
            completed: false,
            createdAt: Date.distantFuture,
            createdBy: "user001",
            dueDate:Date.now,
            id: "task001",
            markdown:
            "# Just a test \n[link](https://google.com)",
            priority: 2,
            title: "Fix the date",
            updatedAt: Date.distantPast,
        )

        return task
    }

    static var previewSet: [TaskSmall] {
        [
            TaskSmall(
                assigneeName: "Dmitry",
                completed: false, dueDate: Calendar.current
                    .date(byAdding: .day, value: 2, to: Date())!, id: "task001",
                priority: 2, title: "Read Swift Documentation",
            ),
            TaskSmall(
                assigneeName: "Alexandra",
                completed: true,
                dueDate: Calendar.current.date(byAdding: .day, value: -5, to: Date())!,
                id: "task002",
                priority: 1,
                title: "Fix Login Bug",
            ),
            TaskSmall(
                assigneeName: "Alexandra",
                completed: true,
                dueDate: Calendar.current.date(byAdding: .day, value: 7, to: Date())!,
                id: "task003",
                priority: 1,
                title: "Fix Login Bug",
            ),  TaskSmall(
                assigneeName: "Alexandra",
                completed: true,
                dueDate: Calendar.current.date(byAdding: .day, value: 14, to: Date())!,
                id: "task004",
                priority: 2,
                title: "Hallo Bug",
            ),
        ]
    }
}
