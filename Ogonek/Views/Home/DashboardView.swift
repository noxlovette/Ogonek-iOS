//
//  DashboardView.swift
//  Ogonek
//
//  Rewritten following Basic Car Maintenance pattern
//

import SwiftUI

struct DashboardView: View {
    @State private var viewModel = DashboardViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    quickActionsCard

                    tasksSection

                    lessonsSection
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
            }
            .navigationTitle("Dashboard")
            .navigationBarTitleDisplayMode(.large)
            .refreshable {
                await viewModel.refreshDashboard()
            }
            .task {
                await viewModel.loadDashboardData()
            }
            .alert("Error", isPresented: .constant(!viewModel.errorMessage.isNil)) {
                Button("Retry") {
                    Task {
                        await viewModel.loadDashboardData()
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
            .overlay {
                if viewModel.isLoading, viewModel.dueTasks.isEmpty {
                    ProgressView("Loading dashboard...")
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.clear)
                }
            }
        }
    }

    private var quickActionsCard: some View {
        NavigationLink {
            LearnView()
        } label: {
            HStack {
                Image(systemName: "brain.head.profile")
                    .font(.title2)
                    .foregroundColor(.blue)

                VStack(alignment: .leading, spacing: 2) {
                    Text("Start Learning")
                        .font(.headline)
                        .foregroundColor(.primary)

                    if viewModel.dueCardsCount > 0 {
                        Text("\(viewModel.dueCardsCount) cards due")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    } else {
                        Text("Review your cards")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding()
            .background(.regularMaterial)
            .cornerRadius(12)
        }
        .buttonStyle(.plain)
    }

    private var tasksSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Tasks")
                    .font(.title2.bold())

                Spacer()

                if !viewModel.dueTasks.isEmpty {
                    Text("\(viewModel.dueTasks.count)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(.secondary.opacity(0.1))
                        .cornerRadius(8)
                }
            }

            if viewModel.dueTasks.isEmpty {
                EmptyStateView(
                    icon: "checkmark.circle.fill",
                    title: "All caught up!",
                    subtitle: "No tasks due right now",
                )
                .padding(.vertical, 20)
            } else {
                LazyVStack(spacing: 8) {
                    ForEach(viewModel.dueTasks) { task in
                        TaskRowView(task: task)
                            .padding()
                            .background(.regularMaterial)
                            .cornerRadius(12)
                    }
                }
            }
        }
    }

    private var lessonsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Lessons")
                    .font(.title2.bold())

                Spacer()

                if !viewModel.recentLessons.isEmpty {
                    Text("\(viewModel.recentLessons.count)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(.secondary.opacity(0.1))
                        .cornerRadius(8)
                }
            }

            if viewModel.recentLessons.isEmpty {
                EmptyStateView(
                    icon: "book.fill",
                    title: "No recent lessons",
                    subtitle: "Your recent lessons will appear here",
                )
                .padding(.vertical, 20)
            } else {
                LazyVStack(spacing: 8) {
                    ForEach(viewModel.recentLessons) { lesson in
                        LessonRowView(lesson: lesson)
                            .padding()
                            .background(.regularMaterial)
                            .cornerRadius(12)
                    }
                }
            }
        }
    }
}

#Preview {
    DashboardView()
}
