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
            id: "wzozO4mi3TfRit5aQbrGp", title: "Task 1", priority: 3, completed: false, dueDate: Date.distantFuture, markdown: "# Just a test \n [link](https://google.com)", createdAt: Date.distantPast, updatedAt: Date.now
        )

        return task
    }
}
