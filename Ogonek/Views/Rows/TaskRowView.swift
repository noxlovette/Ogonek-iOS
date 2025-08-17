import SwiftUI

struct TaskRowView: View {
    let task: TaskSmall

    var body: some View {
        NavigationLink {
            TaskDetailView(taskID: task.id)
        } label: {
            HStack(alignment: .top, spacing: 12) {
                VStack(alignment: .leading, spacing: 6) {
                        // Title and unread indicator
                    HStack(alignment: .top, spacing: 8) {
                        Text(task.title)
                            .font(.headline)
                            .lineLimit(2)
                            .strikethrough(task.completed)
                            .foregroundStyle(task.completed ? .secondary : .primary)
                            .multilineTextAlignment(.leading)

                        Spacer()

                        if !(task.seen ?? false) {
                            Circle()
                                .fill(.red)
                                .frame(width: 8, height: 8)
                        }
                    }

                        // Due date (if exists)
                    if let dueDate = task.dueDate {
                        HStack(spacing: 4) {
                            Image(systemName: "calendar")
                                .font(.caption2)
                            Text("Due \(dueDate, style: .date)")
                                .font(.caption2)
                        }
                        .foregroundStyle(isOverdue ? .red : .secondary)
                    }
                }

                    // Status badge
                if task.completed || isOverdue {
                    statusBadge
                }
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
        }
        .buttonStyle(.plain)
    }

    private var isOverdue: Bool {
        guard let dueDate = task.dueDate else { return false }
        return dueDate < Date() && !task.completed
    }

    @ViewBuilder
    private var statusBadge: some View {
        if task.completed {
            StatusBadge(
                icon: "checkmark.circle.fill",
                text: "Completed",
                color: .green
            )
        } else if isOverdue {
            StatusBadge(
                icon: "exclamationmark.triangle.fill",
                text: "Overdue",
                color: .red
            )
        }
    }
}

#Preview {
    VStack(spacing: 0) {
        TaskRowView(task: MockData.tasks.data[0])
        Divider()
        TaskRowView(task: MockData.tasks.data[1])
        Divider()
        TaskRowView(task: MockData.tasks.data[2])
    }
}
