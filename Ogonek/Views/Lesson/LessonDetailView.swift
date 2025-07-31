//
//  LessonDetailView.swift
//  Ogonek
//
//  Rewritten following Basic Car Maintenance pattern
//

import MarkdownUI
import SwiftUI

struct LessonDetailView: View {
    let lessonId: String

    @State private var viewModel = LessonDetailViewModel()

    var body: some View {
        Group {
            if let lesson = viewModel.lesson {
                lessonContent(lesson: lesson)
            } else if viewModel.isLoading {
                ProgressView("Loading lesson...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if viewModel.errorMessage != nil {
                errorView
            } else {
                emptyView
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.fetchLesson(id: lessonId)
        }
        .alert("Error", isPresented: .constant(!viewModel.errorMessage.isNil)) {
            Button("Retry") {
                Task {
                    await viewModel.fetchLesson(id: lessonId)
                }
            }
            Button("Cancel", role: .cancel) {
                viewModel.errorMessage = nil
            }
        } message: {
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
            }
        }
    }

    // MARK: - Private Views

    private func lessonContent(lesson: Lesson) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                // Header section
                VStack(alignment: .leading, spacing: 12) {
                    Text(lesson.topic)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)

                    HStack {
                        Text("Created \(lesson.createdAt.formatted(.relative(presentation: .named)))")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 8)

                Divider()
                    .padding(.vertical, 16)

                // Content section
                VStack(alignment: .leading, spacing: 16) {
                    Markdown(lesson.markdown)
                }
                .padding(.horizontal, 16)
            }
        }
        .navigationTitle(lesson.topic)
    }

    private var errorView: some View {
        ContentUnavailableView(
            "Failed to Load Lesson",
            systemImage: "exclamationmark.triangle",
            description: Text(viewModel.errorMessage ?? "An unknown error occurred"),
        )
    }

    private var emptyView: some View {
        ContentUnavailableView(
            "Lesson Not Found",
            systemImage: "book.closed",
            description: Text("This lesson could not be found"),
        )
    }
}

#Preview {
    NavigationStack {
        LessonDetailView(lessonId: "preview-id")
    }
}
