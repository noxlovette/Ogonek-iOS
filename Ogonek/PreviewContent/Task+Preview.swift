//
//  Task+Preview.swift
//  Ogonek
//
//  Created by Danila Volkov on 30.07.2025.
//

import Foundation

extension TaskSmall {
    static var preview: PaginatedTasks {
        PaginatedTasks(
            data: [
                TaskSmall(
                    assigneeName: "Charlie Student",
                    completed: false,
                    dueDate: ISO8601DateFormatter().date(from: "2025-07-25T08:27:14.462723Z"),
                    id: "KdqQcCb9jDz-AxQPBMJBo",
                    priority: 1,
                    seen: true,
                    title: "Complete Ownership Exercise"
                ),
                TaskSmall(
                    assigneeName: "Diana Learner",
                    completed: false,
                    dueDate: ISO8601DateFormatter().date(from: "2025-07-30T23:59:59Z"),
                    id: "5NjIP6emp6-HTQLacYTgw",
                    priority: 2,
                    seen: true,
                    title: "Default Title"
                ),
                TaskSmall(
                    assigneeName: "Diana Learner",
                    completed: false,
                    dueDate: ISO8601DateFormatter().date(from: "2025-08-01T08:27:14.462723Z"),
                    id: "Z4sKrZiUDloYVbIcAiapb",
                    priority: 1,
                    seen: true,
                    title: "Build Async Web Scraper"
                ),
                TaskSmall(
                    assigneeName: "Alice Teacher",
                    completed: false,
                    dueDate: nil,
                    id: "H5rYRaTVohG9u1AoBIo1y",
                    priority: 1,
                    seen: true,
                    title: "Default Title"
                ),
                TaskSmall(
                    assigneeName: "Alice Teacher",
                    completed: false,
                    dueDate: nil,
                    id: "Bzgbqk11luSf32OB48pQA",
                    priority: 3,
                    seen: true,
                    title: "Default Title"
                ),
                TaskSmall(
                    assigneeName: "Alice Teacher",
                    completed: false,
                    dueDate: nil,
                    id: "MwcjD6dZLJo0BpCDwqTrK",
                    priority: 1,
                    seen: true,
                    title: "Default Title"
                ),
                TaskSmall(
                    assigneeName: "Alice Teacher",
                    completed: false,
                    dueDate: nil,
                    id: "70f7EBo2fPAk13a2PT4-I",
                    priority: 1,
                    seen: true,
                    title: "New TaskSmall"
                ),
                TaskSmall(
                    assigneeName: "Alice Teacher",
                    completed: false,
                    dueDate: nil,
                    id: "x9xi83u9FYhvSc40FtoIj",
                    priority: 1,
                    seen: false,
                    title: "Testing File Deletion"
                )
            ],
            page: 1,
            perPage: 20,
            total: 9
        )
    }
}
