//
//  Toolbar+TaskList.swift
//  Ogonek
//
//  Created by Danila Volkov on 09.08.2025.
//

import SwiftUI

extension TaskListView {
    @ToolbarContentBuilder
    func toolbarContent() -> some ToolbarContent {
        ToolbarItemGroup(placement: .topBarTrailing) {
            RefreshButton {
                refreshTasks()
            }
            .accessibilityLabel("Refresh tasks")
            .accessibilityHint("Updates task list with latest data")

            Button(action: requestMoreTasks) {
                Label("Homework Request", systemImage: "bell.badge")
            }
        }
    }
}
