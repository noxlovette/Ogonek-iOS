import SwiftUI

struct TaskRowView: View {
    let task: TaskSmall

    var body: some View {
        NavigationLink {
            TaskDetailView(taskID: task.id)
        } label: {
            HStack(alignment: .top, spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    Text(task.title)
                        .font(.headline)
                        .lineLimit(2)
                        .strikethrough(task.completed)
                        .foregroundStyle(task.completed ? .secondary : .primary)
                        .multilineTextAlignment(.leading)

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

                Spacer(minLength: 0)

                statusBadge
            }
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
                color: .green,
            )
        } else if isOverdue {
            StatusBadge(
                icon: "exclamationmark.triangle.fill",
                text: "Overdue",
                color: .red,
            )
        }
    }
}

#Preview {
    TaskRowView(task: MockData.tasks.data[0])
}
