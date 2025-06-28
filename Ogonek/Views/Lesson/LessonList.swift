//
//  LessonList.swift
//  Ogonek Swift
//
//  Created by Danila Volkov on 29.04.2025.
//

import Foundation
import SwiftUI

struct LessonListView: View {
    @AppStorage("lastUpdated")
    var lastUpdated = Date.distantFuture.timeIntervalSince1970

    @Environment(LessonsProvider.self) var provider
    @State var editMode: EditMode = .inactive
    @State var selectMode: SelectMode = .inactive
    @State var isLoading = false
    @State var selection: Set<String> = []
    @State private var error: LessonError?
    @State private var hasError = false

    var body: some View {
        NavigationStack {
            List(selection: $selection) {
                ForEach(provider.lessons) { lesson in
                    LessonRow(lesson: lesson)
                }
            }
            .listStyle(.inset)
            .navigationTitle(title)
            .environment(\.editMode, $editMode)
            .refreshable {
                await fetchLessons()
            }.navigationDestination(for: Lesson.self) { lesson in
                LessonDetail(lesson: lesson)
            }
            .alert(isPresented: $hasError, error: error) {}
        }

        .task {
            await fetchLessons()
        }
    }
}

extension LessonListView {
    var title: String {
        if editMode == .active && !selection.isEmpty {
            return "\(selection.count) Selected"
        } else {
            return "Lessons"
        }
    }

    func fetchLessons() async {
        logger.info("Fetching Lessons underway")
        isLoading = true
        do {
            try await provider.fetchLessons()
            lastUpdated = Date().timeIntervalSince1970

        } catch {
            self.error = error as? LessonError ?? .core(.unexpectedError(error))
            hasError = true
        }
        isLoading = false
    }
}

#Preview {
    LessonListView()
        .environment(
            LessonsProvider(client:
                LessonClient(downloader: TestDownloader()))
        )
}
