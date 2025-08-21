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
        if let taskWithFiles = viewModel.taskWithFiles {
            ToolbarItem(placement: .bottomBar) {
                if let dueDate = taskWithFiles.task.dueDate {
                    Text("Due: \(dueDate, style: .date)")
                        .font(.caption)
                }
            }

            ToolbarItemGroup(placement: .topBarTrailing) {
                DownloadButton(action: downloadTask)
                CompleteButton(
                    action: markAsComplete,
                    condition: taskWithFiles.task.completed,
                    recto: "Completed",
                    verso: "Complete"
                )
                .tint(taskWithFiles.task.completed
                    == true ? .green : .accent)
            }
        }
    }
}
