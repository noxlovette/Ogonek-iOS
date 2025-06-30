//
//  TaskList.swift
//  Ogonek
//
//  Created by Danila Volkov on 28.06.2025.
//

import SwiftUI

struct TaskListView: View {
    @AppStorage("lastUpdated")
    var lastUpdated = Date.distantFuture.timeIntervalSince1970

    @Environment(TaskProvider.self) var provider
    @State var isLoading = false
    @State private var error: AssignmentError?
    @State private var hasError = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(provider.tasks) { task in TaskRow(task: task) }
            }
            .refreshable {
                await fetchTasks()
            }
            .navigationTitle("Tasks")
            .navigationDestination(for: Assignment.self) {
                task in TaskDetail(task: task)
            }
            .listStyle(.inset)
            .alert(isPresented: $hasError, error: error) {}
        }
        .task {
            await fetchTasks()
        }
    }
}

extension TaskListView {
    func fetchTasks() async {
        logger.debug("Fetching tasks...")
        isLoading = true
        defer {
            isLoading = false
        }

        do {
            try await provider.fetchTasks()
            lastUpdated = Date().timeIntervalSince1970
        } catch {
            self.error = error as? AssignmentError ?? .core(.unexpectedError(error))
            hasError = true
        }
        isLoading = false
    }
}

#Preview {
    TaskListView()
        .environment(
            TaskProvider(client: TaskClient(downloader: TestDownloader())))
}
