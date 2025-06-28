/*
See LICENSE folder for this sample’s licensing information.

Abstract:
The toolbar for the Quakes view.
*/

import SwiftUI

extension LessonListView {

    @ToolbarContentBuilder
    func toolbarContent() -> some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            if editMode == .active {
                SelectButton(mode: $selectMode) {
                    if selectMode.isActive {
                        selection = Set(provider.lessons.map { $0.id })
                    } else {
                        selection = []
                    }
                }
            }
        }
        ToolbarItem(placement: .navigationBarTrailing) {
            EditButton(editMode: $editMode) {
                selection.removeAll()
                editMode = .inactive
                selectMode = .inactive
            }
        }
        ToolbarItemGroup(placement: .bottomBar) {
            RefreshButton {
                Task {
                    await fetchLessons()
                }
            }
            Spacer()
            ToolbarStatus(
                isLoading: isLoading,
                lastUpdated: lastUpdated,
                lessonsCount: provider.lessons.count
            )
            Spacer()
           
        }
    }
}
