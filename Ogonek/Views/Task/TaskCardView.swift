import SwiftUI

// MARK: - Task Card Component

struct TaskCardView: View {
    let task: TaskSmall

    var body: some View {
        NavigationLink(
            destination: TaskDetailView(taskId: task.id),
        ) {
            GenericCardView(
                backgroundColor: Color(.systemBackground),
                cornerRadius: 12,
                shadowRadius: 2,
                borderColor: task.completed ? Color.green.opacity(0.3) : Color(.systemGray4),
                borderWidth: task.completed ? 2 : 1,
                action: {
                    // Navigate to task detail
                    print("Tapped task: \(task.title)")
                },
            ) {
                VStack(alignment: .leading, spacing: 16) {
                    // Header section with title and completion status
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(task.title)
                                .font(.headline)
                                .fontWeight(.semibold)
                                .foregroundColor(.primary)
                                .lineLimit(2)
                                .strikethrough(task.completed)
                        }

                        Spacer()

                        // Completion status icon
                        Image(systemName: task.completed ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(task.completed ? .green : Color(.systemGray3))
                            .font(.title2)
                    }

                    // Footer with dates and status
                    HStack {
                        VStack(alignment: .leading, spacing: 2) {
                            if let dueDate = task.dueDate {
                                HStack(spacing: 4) {
                                    Image(systemName: "calendar")
                                        .font(.caption2)
                                    Text("Due: \(dueDate, style: .date)")
                                        .font(.caption2)
                                }
                                .foregroundColor(dueDate < Date() && !task.completed ? .red : .secondary)
                            }

                        }

                        Spacer()

                        // Status badge
                        if task.completed {
                            Text("Completed")
                                .font(.caption2)
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.green)
                                .cornerRadius(6)
                        } else if let dueDate = task.dueDate, dueDate < Date() {
                            Text("Overdue")
                                .font(.caption2)
                                .fontWeight(.medium)
                                .foregroundColor(.white)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color.red)
                                .cornerRadius(6)
                        }
                    }
                }
            }
        }
    }
}
