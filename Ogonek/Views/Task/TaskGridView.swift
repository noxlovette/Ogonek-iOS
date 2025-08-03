//
//  TaskGridView.swift
//  Ogonek
//
//  Created by Danila Volkov on 12.07.2025.
//

import SwiftUI

// MARK: - Empty State View

private struct TaskEmptyStateView: View {
    @State private var isShowingAlert = false

    private let motivationalPhrases = [
        "Feed Me Tasks!",
        "More Work Please!",
        "Task Drought... Help!",
        "Bored Student Here!",
        "Challenge Me!",
        "My Brain Needs Exercise!",
        "Send Homework My Way!",
    ]

    private var randomPhrase: String {
        motivationalPhrases.randomElement() ?? "Request More Tasks"
    }

    var body: some View {
        VStack(spacing: 24) {
            // Icon and main message
            VStack(spacing: 16) {
                Image(systemName: "tray.fill")
                    .font(.system(size: 64))
                    .foregroundColor(Color(.systemGray3))

                Text("Task Inbox Zero")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
            }

            // Description
            Text("Wow, you've completed all your tasks! Time to either celebrate or ask for more challenges.")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemGroupedBackground))
    }
}

// MARK: - Main Tasks View

struct TaskGridView: View {
    @State private var showCompleted: Bool = false
    @State private var isLoading: Bool = false
    @State private var viewModel = TaskGridViewModel()

    private var filteredTasks: [TaskSmall] {
        if showCompleted {
            viewModel.tasks
        } else {
            viewModel.tasks.filter { !$0.completed }
        }
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Header section
                VStack(spacing: 16) {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Tasks")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                        }

                        Spacer()

                        // Show/Hide completed toggle
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.2)) {
                                showCompleted.toggle()
                            }
                        }) {
                            HStack(spacing: 6) {
                                Image(systemName: showCompleted ? "eye.slash" : "eye")
                                    .font(.body)
                                Text(showCompleted ? "Hide Completed" : "Show Completed")
                                    .fontWeight(.medium)
                            }
                            .foregroundColor(.white)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                            .background(Color.brown) // Using brown as "cacao" equivalent
                            .cornerRadius(8)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.horizontal)
                .padding(.top)
                .background(Color(.systemGroupedBackground))

                // Content area
                if isLoading {
                    Spacer()
                    ProgressView("Loading tasks...")
                        .font(.headline)
                        .foregroundColor(.secondary)
                    Spacer()
                } else if filteredTasks.isEmpty, !showCompleted {
                    // Empty state for student role
                    TaskEmptyStateView()
                } else if filteredTasks.isEmpty {
                    // No tasks at all
                    VStack(spacing: 16) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 64))
                            .foregroundColor(.green)

                        Text("All caught up!")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.primary)

                        Text("You have no tasks at the moment.")
                            .font(.body)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    // Task grid
                    ScrollView {
                        LazyVGrid(columns: [
                            GridItem(.flexible(), spacing: 16),
                        ], spacing: 16) {
                            ForEach(filteredTasks, id: \.id) { task in
                                TaskCardView(task: task)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top)
                    }
                    .background(Color(.systemGroupedBackground))
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationBarHidden(true)
        }
        .task {
            await viewModel.loadTasks()
        }
        .refreshable {
            await viewModel.refreshTasks()
        } // TODO: ADD SEARCH FUNCTIONALITY
    }
}

// MARK: - Preview

struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TaskGridView()
            .preferredColorScheme(.light)

        TaskGridView()
            .preferredColorScheme(.dark)
    }
}
