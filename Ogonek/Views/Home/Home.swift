//
//  Home.swift
//  Ogonek
//
//  Created by Danila Volkov on 28.06.2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 20) {
                    // Quick action - just flashcards
                    QuickActionCard()

                    // Due tasks section
                    DueTasksSection(tasks: viewModel.dueTasks)

                    // Recent activity feed
                    RecentActivitySection(activities: viewModel.recentActivities)
                }
                .padding()
            }
            .navigationTitle("Ogonek")
            .navigationBarTitleDisplayMode(.large)
            .refreshable {
                await viewModel.refresh()
            }
        }
        .task {
            await viewModel.loadData()
        }
    }
}

// MARK: - Quick Action Card

struct QuickActionCard: View {
    var body: some View {
        Button(action: {
            // Navigate to flashcards
        }) {
            HStack {
                Image(systemName: "brain.head.profile")
                    .font(.title2)
                    .foregroundColor(.cocoaAccent)

                VStack(alignment: .leading, spacing: 2) {
                    Text("Start Flashcards")
                        .font(.headline)
                        .foregroundColor(.primary)

                    Text("Review your cards")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding()
            .background(Color.stoneLight)
            .cornerRadius(12)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Due Tasks Section

struct DueTasksSection: View {
    let tasks: [Assignment]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Due Tasks")
                    .font(.title2)
                    .fontWeight(.semibold)

                Spacer()

                if !tasks.isEmpty {
                    Text("\(tasks.count)")
                        .font(.caption)
                        .foregroundColor(.white)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.red)
                        .cornerRadius(8)
                }
            }

            if tasks.isEmpty {
                EmptyStateView(
                    icon: "checkmark.circle",
                    title: "All caught up!",
                    subtitle: "No tasks due right now"
                )
            } else {
                ForEach(tasks.prefix(3)) { task in
                    TaskRowView(task: task)
                }

                if tasks.count > 3 {
                    NavigationLink("View all \(tasks.count) tasks") {
                        // Navigate to full tasks view
                    }
                    .font(.subheadline)
                    .foregroundColor(.cocoaAccent)
                }
            }
        }
    }
}

// MARK: - Recent Activity Section

struct RecentActivitySection: View {
    let activities: [RecentActivity]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Recent Activity")
                .font(.title2)
                .fontWeight(.semibold)

            if activities.isEmpty {
                EmptyStateView(
                    icon: "clock",
                    title: "No recent activity",
                    subtitle: "Start adding lessons or tasks"
                )
            } else {
                ForEach(activities.prefix(5)) { activity in
                    ActivityRowView(activity: activity)
                }
            }
        }
    }
}

// MARK: - Supporting Views

struct TaskRowView: View {
    let task: Assignment

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text(task.title)
                    .font(.subheadline)
                    .fontWeight(.medium)

                if let dueDate = task.dueDate {
                    Text(dueDate, style: .relative)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }

            Spacer()

            // TODO: isOverview
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .background(Color.stoneLight)
        .cornerRadius(8)
    }
}

struct ActivityRowView: View {
    let activity: RecentActivity

    var body: some View {
        HStack {
            Image(systemName: activity.icon)
                .foregroundColor(.cocoaAccent)
                .frame(width: 24, height: 24)

            VStack(alignment: .leading, spacing: 2) {
                Text(activity.title)
                    .font(.subheadline)
                    .fontWeight(.medium)

                Text(activity.timestamp, style: .relative)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer()
        }
        .padding(.vertical, 8)
    }
}

private struct EmptyStateView: View {
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
        .background(Color.stoneLight)
        .cornerRadius(12)
    }
}

// MARK: - Data Models

struct RecentActivity: Identifiable {
    let id = UUID()
    let title: String
    let timestamp: Date
    let type: ActivityType

    var icon: String {
        switch type {
        case .taskAdded: return "plus.circle.fill"
        case .deckAdded: return "rectangle.stack.fill"
        case .lessonAdded: return "book.fill"
        case .taskCompleted: return "checkmark.circle.fill"
        }
    }
}

enum ActivityType {
    case taskAdded
    case deckAdded
    case lessonAdded
    case taskCompleted
}

// MARK: - View Model

@MainActor
class HomeViewModel: ObservableObject {
    @Published var dueTasks: [Assignment] = []
    @Published var recentActivities: [RecentActivity] = []
    @Published var isLoading = false

    func loadData() async {
        isLoading = true

        dueTasks = Array(Assignment.previewSet[0 ... 1])

        recentActivities = [
            RecentActivity(title: "Added new deck: Spanish Vocabulary", timestamp: Date().addingTimeInterval(-3600), type: .deckAdded),
            RecentActivity(title: "Completed task: Math homework", timestamp: Date().addingTimeInterval(-7200), type: .taskCompleted),
            RecentActivity(title: "Added lesson: History Chapter 5", timestamp: Date().addingTimeInterval(-10800), type: .lessonAdded),
        ]

        isLoading = false
    }

    func refresh() async {
        await loadData()
    }
}

// MARK: - Color Extensions

extension Color {
    static let stoneLight = Color(red: 0.95, green: 0.95, blue: 0.95)
    static let stoneDark = Color(red: 0.2, green: 0.2, blue: 0.2)
    static let cocoaAccent = Color(red: 0.8, green: 0.6, blue: 0.4)
}

// MARK: - Preview

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
