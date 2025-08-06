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
            Group {
                if viewModel.tasks.isEmpty, !viewModel.isLoading {
                    EmptyView()
                } else {
                    tasksList
                }
            }
            .navigationTitle("Tasks")
            .searchable(text: $searchText, prompt: "Search tasks...")
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

    private var tasksList: some View {
        List {
            ForEach(viewModel.tasks) { task in
                    TaskRowView(task: task)
            }

            if viewModel.isLoading, !viewModel.tasks.isEmpty {
                HStack {
                    Spacer()
                    ProgressView()
                        .padding()
                    Spacer()
                }
            }
        }
        .listStyle(.inset)
        .navigationDestination(for: String.self) { taskID in // This receives the task ID
            TaskDetailView(taskID: taskID)
        }
        .overlay {
            if viewModel.isLoading, viewModel.tasks.isEmpty {
                ProgressView("Loading tasks...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.clear)
            }
        }
    }
}

#Preview {
    TaskListView()
}
