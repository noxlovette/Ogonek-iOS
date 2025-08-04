import SwiftUI

struct TaskRowView: View {
    let task: TaskSmall

    var body: some View {
        NavigationLink {
            TaskDetailView(taskId: task.id)
        } label: {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(task.title)
                        .font(.headline)
                        .lineLimit(2)
                        .strikethrough(task.completed)
                        .foregroundColor(task.completed ? .secondary : .primary)

                    HStack {
                        if let dueDate = task.dueDate {
                            HStack(spacing: 4) {
                                Image(systemName: "calendar")
                                    .font(.caption2)
                                Text("Due: \(dueDate, style: .date)")
                                    .font(.caption2)
                            }
                            .foregroundColor(dueDate < Date() && !task.completed ? .red : .secondary)
                        }

                        Spacer()
                    }
                }

                Spacer()

                VStack {
                    if task.completed {
                        HStack(spacing: 4) {
                            Image(systemName: "checkmark.circle.fill")
                                .font(.caption)
                                .foregroundColor(.green)
                            Text("Completed")
                                .font(.caption2)
                                .fontWeight(.medium)
                                .foregroundColor(.green)
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(.green.opacity(0.1))
                        .cornerRadius(6)
                    } else if let dueDate = task.dueDate, dueDate < Date() {
                        HStack(spacing: 4) {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .font(.caption)
                                .foregroundColor(.red)
                            Text("Overdue")
                                .font(.caption2)
                                .fontWeight(.medium)
                                .foregroundColor(.red)
                        }
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(.red.opacity(0.1))
                        .cornerRadius(6)
                    }
                }
            }
        }
    }
}

#Preview {
    TaskRowView(task: MockData.tasks.data[0])
}
