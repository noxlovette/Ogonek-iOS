    //
    //  LessonList.swift
    //  Ogonek Swift
    //
    //  Created by Danila Volkov on 29.04.2025.
    //

import Foundation
import SwiftUI

struct LessonListView: View {
        // MARK: - Dependencies
    @Environment(LessonProvider.self) var provider

        // MARK: - Persistent State
    @AppStorage("lastUpdated") var lastUpdated = Date.distantPast.timeIntervalSince1970

        // MARK: - View State
    @State private var viewState = ViewState()

        // MARK: - Constants
    private let cacheTimeout: TimeInterval = 300 // 5 minutes

    var body: some View {
        NavigationStack {
            Group {
                if provider.lessons.isEmpty && !viewState.isLoading {
                    emptyStateView
                } else {
                    lessonsList
                }
            }
            .navigationTitle(title)

         
            .environment(\.editMode, $viewState.editMode)
            .alert(isPresented: $viewState.hasError, error: viewState.error) {
                Button("Retry") {
                    Task { await fetchLessons() }
                }
            }
        }
        .task {
            await fetchLessonsIfNeeded()
        }
    }

        // MARK: - Private Views
    private var lessonsList: some View {
        List(selection: $viewState.selection) {
            ForEach(provider.lessons) { lesson in
                LessonRow(lesson: lesson)
            }
            .onDelete(perform: deleteLessons)
        }
        .listStyle(.inset)
        .refreshable {
            await fetchLessons()
        }
        .navigationDestination(for: Lesson.self) { lesson in
            LessonDetailView(lesson: lesson)
        }
        .overlay {
            if viewState.isLoading {
                ProgressView("Loading lessons...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.clear)
            }
        }
    }

    private var emptyStateView: some View {
        ContentUnavailableView(
            "No Lessons Available",
            systemImage: "book.closed",
            description: Text("Pull to refresh or check your connection")
        )
    }
}

    // MARK: - Extensions
extension LessonListView {
    var title: String {
        if viewState.editMode == .active && !viewState.selection.isEmpty {
            return "\(viewState.selection.count) Selected"
        } else {
            return "Lessons"
        }
    }

    private func fetchLessonsIfNeeded() async {
            // Only fetch if data is stale (older than cache timeout) or empty
        let cacheExpiry = Date().timeIntervalSince1970 - cacheTimeout

        if lastUpdated < cacheExpiry || provider.lessons.isEmpty {
            await fetchLessons()
        }
    }

    func fetchLessons() async {
        logger.info("Fetching lessons...")
        viewState.isLoading = true

        do {
            try await provider.fetchLessons()
            lastUpdated = Date().timeIntervalSince1970
        } catch let lessonError as LessonError {
            viewState.error = lessonError
            viewState.hasError = true
        } catch {
            viewState.error = .core(.unexpectedError(error))
            viewState.hasError = true
            logger.error("Unexpected error fetching lessons: \(error)")
        }

        viewState.isLoading = false
    }

    private func deleteLessons(offsets: IndexSet) {
        withAnimation {
                // Implement deletion logic here if needed
                // provider.deleteLessons(at: offsets)
        }
    }
}

    // MARK: - ViewState
extension LessonListView {
    struct ViewState {
        var editMode: EditMode = .inactive
        var selectMode: SelectMode = .inactive
        var isLoading = false
        var selection: Set<String> = []
        var error: LessonError?
        var hasError = false
    }
}

    // MARK: - Preview
#Preview {
    LessonListView()
        .environment(
            LessonProvider(client:
                            LessonClient(downloader: TestDownloader()))
        )
}
