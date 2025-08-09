//
//  Toolbar+LessonDetail.swift
//  Ogonek
//
//  Created by Danila Volkov on 09.08.2025.
//

import SwiftUI

extension LessonDetailView {
    @ToolbarContentBuilder
    func toolbarContent() -> some ToolbarContent {
        ToolbarItem(placement: .bottomBar) {
            Button("Download", action: downloadLesson)
        }
    }
}
