//
//  LessonListView.swift
//  Ogonek
//
//  Rewritten following Basic Car Maintenance pattern
//

import SwiftUI

struct LessonListView: View {
    @State private var viewModel = LessonListViewModel()
    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.lessons.isEmpty, !viewModel.isLoading {
                    emptyStateView
                } else {
                    lessonsList
                }
            }
            .navigationTitle("Lessons")
            .searchable(text: $searchText, prompt: "Search lessons...")
            .refreshable {
                await viewModel.refreshLessons()
            }
            .task {
                await viewModel.loadLessons()
            }
            .onChange(of: searchText) { _, newValue in
                Task {
                    await viewModel.searchLessons(query: newValue)
                }
            }
        }
        .alert("Error", isPresented: .constant(!viewModel.errorMessage.isNil)) {
            Button("OK") {
                viewModel.errorMessage = nil
            }
        } message: {
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
            }
        }
    }

    // MARK: - Private Views

    private var lessonsList: some View {
        List {
            ForEach(viewModel.lessons) { lesson in
                NavigationLink(value: lesson.id) {
                    LessonRowView(lesson: lesson)
                }
                .onAppear {
                    // Load more when reaching the last few items
                    if lesson.id == viewModel.lessons.last?.id {
                        Task {
                            await viewModel.loadMoreLessons()
                        }
                    }
                }
            }

            if viewModel.isLoading, !viewModel.lessons.isEmpty {
                HStack {
                    Spacer()
                    ProgressView()
                        .padding()
                    Spacer()
                }
            }
        }
        .listStyle(.inset)
        .navigationDestination(for: String.self) { lessonId in
            LessonDetailView(lessonId: lessonId)
        }
        .overlay {
            if viewModel.isLoading, viewModel.lessons.isEmpty {
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
            description: Text("Pull to refresh or check your connection"),
        )
    }
}

#Preview {
    NavigationStack {
        LessonListView()
    }
}
