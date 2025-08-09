//
//  Toolbar+TaskDetail.swift
//  Ogonek
//
//  Created by Danila Volkov on 09.08.2025.
//

import SwiftUI

extension TaskDetailView {
    @ToolbarContentBuilder
    func toolbarContent() -> some ToolbarContent {
        ToolbarItem {
            if let dueDate = viewModel.taskWithFiles.task.dueDate {
                Text("Due: \(dueDate, style: .date)")
            }
        }

        ToolbarItemGroup(placement: .bottomBar) {
            Button("Download", action: downloadTask)
            Spacer()

            Button(viewModel.taskWithFiles.task.completed == true ?
                "Completed" : "Complete", action: markAsComplete)
        }
    }
}
