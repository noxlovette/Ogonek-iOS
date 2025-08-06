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
                    EmptyView()
                } else {
                    lessonsList
                }
            }
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
                LessonRowView(lesson: lesson)
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
        .overlay {
            if viewModel.isLoading, viewModel.lessons.isEmpty {
                ProgressView("Loading lessons...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.clear)
            }
        }
    }
}

#Preview {
    NavigationStack {
        LessonListView()
    }
}
