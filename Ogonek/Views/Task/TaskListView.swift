//
//  TaskListView.swift
//  Ogonek
//
//  Created by Danila Volkov on 12.07.2025.
//

import SwiftUI

struct TaskListView: View {
    @State private var viewModel = TaskListViewModel()
    @State private var searchText = ""

    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.tasks) { task in
                    TaskRowView(task: task)
                }
            }
            .listStyle(.inset)
            .navigationTitle("Tasks")
            .searchable(text: $searchText, prompt: "Search tasks...")
            .accessibilityLabel("Search tasks")
            .accessibilityHint("Type to filter task list")
            .refreshable {
                await viewModel.refreshTasks()
            }
            .task {
                await viewModel.loadTasks()
            }
            .onChange(of: searchText) { _, newValue in
                Task {
                    await viewModel.searchTasks(query: newValue)
                }
            }
            .overlay {
                if viewModel.isLoading && viewModel.tasks.isEmpty {
                    ProgressView("Loading tasks...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.clear)
                } else if viewModel.tasks.isEmpty {
                    EmptyStateView(
                        icon: "magnifyingglass",
                        title: "No tasks",
                        description: "Click the bell button to ask for more"
                    )
                } else if viewModel.tasks.isEmpty, searchText != "" {
                    EmptyStateView(
                        icon: "magnifyingglass",
                        title: "No tasks found",
                        description: "Try a different search"
                    )
                }
            }
            .toolbar {
                toolbarContent()
            }
        }

        .alert("Error", isPresented: .constant(viewModel.errorMessage != nil)) {
            Button("OK") {
                viewModel.errorMessage = nil
            }
        } message: {
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
            }
        }
    }

    func requestMoreTasks() {
        Task {
            await viewModel.requestMoreTasks()
        }
    }

    func refreshTasks() {
        Task {
            await viewModel.refreshTasks()
        }
    }
}

#Preview {
    TaskListView()
}
