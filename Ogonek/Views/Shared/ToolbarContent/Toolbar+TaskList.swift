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
        ToolbarItem {
            RefreshButton {
                refreshTasks()
            }
            .accessibilityLabel("Refresh tasks")
            .accessibilityHint("Updates task list with latest data")
        }

        ToolbarItem {
            Button(
                "Notify teacher",
                systemImage: "bell",
                action: requestMoreTasks
            )
        }
    }
}
