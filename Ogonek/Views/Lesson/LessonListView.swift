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
            List {
                ForEach(viewModel.lessons) { lesson in
                    LessonRowView(lesson: lesson)
                }
            }
            .listStyle(.inset)
            .navigationTitle("Lessons")
            .searchable(text: $searchText, prompt: "Search lessons...")
            .task {
                await viewModel.loadLessons()
            }
            .refreshable {
                await viewModel.refreshLessons()
            }
            .onChange(of: searchText) { _, newValue in
                Task {
                    await viewModel.searchLessons(query: newValue)
                }
            }
            .toolbar {
                toolbarContent()
            }
            .overlay {
                if viewModel.isLoading, viewModel.lessons.isEmpty {
                    ProgressView("Loading lessons...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.clear)
                } else if viewModel.lessons.isEmpty {
                    EmptyStateView(icon: "magnifyingglass", title: "No lessons", description: "Wait for your teacher to add some")
                } else if viewModel.lessons.isEmpty, searchText != "" {
                    EmptyStateView(icon: "magnifyingglass", title: "No lessons found", description: "Try a different search")
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

    func refreshLessons() {
        Task {
            await viewModel.refreshLessons()
        }
    }
}

#Preview {
    NavigationStack {
        LessonListView()
    }
}
