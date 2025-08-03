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
                LazyVStack(spacing: 20) {
                    QuickActionsCard(dueCardsCount: viewModel.dueCardsCount)

                    // Due Tasks Section
                    DueTasksSection(
                        tasks: viewModel.dueTasks,
                        isLoading: viewModel.isLoading,
                    )

                    // Recent Lessons Section
                    RecentLessonsSection(
                        lessons: viewModel.recentLessons,
                        isLoading: viewModel.isLoading,
                    )
                }
                .padding()
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
}

// MARK: - Quick Actions Card

struct QuickActionsCard: View {
    let dueCardsCount: Int64

    var body: some View {
        VStack(spacing: 12) {
            // Main flashcards action
            NavigationLink {
                // Navigate to flashcards/learn view
                LearnView()
            } label: {
                HStack {
                    Image(systemName: "brain.head.profile")
                        .font(.title2)

                    VStack(alignment: .leading, spacing: 2) {
                        Text("Start Learning")
                            .font(.headline)
                            .foregroundColor(.primary)

                        if dueCardsCount > 0 {
                            Text("\(dueCardsCount) cards due")
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
                .cornerRadius(12)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

// MARK: - Due Tasks Section

struct DueTasksSection: View {
    let tasks: [TaskSmall]
    let isLoading: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionHeader(
                title: "Due Tasks",
                count: tasks.count,
                countColor: tasks.isEmpty ? nil : .red,
            )

            if isLoading, tasks.isEmpty {
                SkeletonTaskRows()
            } else if tasks.isEmpty {
                EmptyStateView(
                    icon: "checkmark.circle",
                    title: "All caught up!",
                    subtitle: "No tasks due right now",
                )
            } else {
                LazyVStack(spacing: 8) {
                    ForEach(tasks, id: \.id) { _ in
                        Text("PLACE THE LINK HERE")
                    }
                }

                if tasks.count >= 3 {
                    NavigationLink {
                        TaskGridView()
                    } label: {
                        Text("View all tasks")
                            .font(.subheadline)
                    }
                }
            }
        }
    }
}

// MARK: - Recent Lessons Section

struct RecentLessonsSection: View {
    let lessons: [LessonSmall]
    let isLoading: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionHeader(title: "Recent Lessons")

            if isLoading, lessons.isEmpty {
                SkeletonLessonRows()
            } else if lessons.isEmpty {
                EmptyStateView(
                    icon: "book.closed",
                    title: "No recent lessons",
                    subtitle: "Create your first lesson",
                )
            } else {
                LazyVStack(spacing: 8) {
                    ForEach(lessons, id: \.id) { lesson in
                        NavigationLink {
                            LessonDetailView(lessonId: lesson.id)
                        } label: {
                            LessonRowView(lesson: lesson)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }

                if lessons.count >= 3 {
                    NavigationLink {
                        LessonListView()
                    } label: {
                        Text("View all lessons")
                            .font(.subheadline)
                    }
                }
            }
        }
    }
}

// MARK: - Supporting Views

struct SectionHeader: View {
    let title: String
    let count: Int?
    let countColor: Color?

    init(title: String, count: Int? = nil, countColor: Color? = nil) {
        self.title = title
        self.count = count
        self.countColor = countColor
    }

    var body: some View {
        HStack {
            Text(title)
                .font(.title2)
                .fontWeight(.semibold)

            Spacer()

            if let count, count > 0 {
                Text("\(count)")
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(countColor ?? .blue)
                    .cornerRadius(8)
            }
        }
    }
}

struct TaskRowView: View {
    let task: TaskSmall

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(task.title)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundColor(.primary)
                    .lineLimit(2)

                HStack {
                    if let dueDate = task.dueDate {
                        Text(dueDate, style: .relative)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }

                    Spacer()

                    PriorityIndicator(priority: task.priority)
                }
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.caption2)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .cornerRadius(8)
    }
}

struct PriorityIndicator: View {
    let priority: Int32

    var body: some View {
        HStack(spacing: 2) {
            ForEach(0 ..< Int(priority), id: \.self) { _ in
                Circle()
                    .fill(priorityColor)
                    .frame(width: 4, height: 4)
            }
        }
    }

    private var priorityColor: Color {
        switch priority {
        case 1: .red
        case 2: .orange
        case 3: .yellow
        default: .gray
        }
    }
}

struct EmptyStateView: View {
    let icon: String
    let title: String
    let subtitle: String

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(.secondary)

            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)

            Text(subtitle)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .cornerRadius(12)
    }
}

// MARK: - Skeleton Loading Views

struct SkeletonTaskRows: View {
    var body: some View {
        LazyVStack(spacing: 8) {
            ForEach(0 ..< 3, id: \.self) { _ in
                SkeletonRow()
            }
        }
    }
}

struct SkeletonLessonRows: View {
    var body: some View {
        LazyVStack(spacing: 8) {
            ForEach(0 ..< 3, id: \.self) { _ in
                SkeletonRow()
            }
        }
    }
}

struct SkeletonActivityRows: View {
    var body: some View {
        LazyVStack(spacing: 8) {
            ForEach(0 ..< 5, id: \.self) { _ in
                SkeletonRow(height: 40)
            }
        }
    }
}

struct SkeletonRow: View {
    let height: CGFloat

    init(height: CGFloat = 60) {
        self.height = height
    }

    var body: some View {
        Rectangle()
            .fill(Color.gray.opacity(0.2))
            .frame(height: height)
            .cornerRadius(8)
            .redacted(reason: .placeholder)
    }
}

// MARK: - Preview

#Preview {
    DashboardView()
}
