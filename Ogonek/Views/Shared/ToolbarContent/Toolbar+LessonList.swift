//
//  Toolbar+LessonList.swift
//  Ogonek
//
//  Created by Danila Volkov on 09.08.2025.
//

import SwiftUI

extension LessonListView {
    @ToolbarContentBuilder
    func toolbarContent() -> some ToolbarContent {
        ToolbarItem {
            RefreshButton {
                refreshLessons()
            }
            .accessibilityLabel("Refresh lessons")
            .accessibilityHint("Updates lesson list with latest data")
        }
    }
}
