import SwiftUI

struct DeckRowView: View {
    let deck: DeckSmall

    var body: some View {
        BaseRowView(
            destination: DeckDetailView(deckId: deck.id),
            title: deck.title,
            seen: deck.seen ?? false
        ) {
            HStack(spacing: 4) {
                Image(systemName: "rectangle.stack")
                Text("\(deck.cardCount) cards")
            }
        } trailing: {
            if deck.isSubscribed == true {
                StatusBadge(icon: "checkmark.seal", text: "Subscribed", color: .green)
            }
        }
    }
}

struct LessonRowView: View {
    let lesson: LessonSmall

    var body: some View {
        BaseRowView(
            destination: LessonDetailView(lessonID: lesson.id),
            title: lesson.topic,
            seen: lesson.seen ?? false
        ) {
            HStack(spacing: 4) {
                Image(systemName: "clock")
                Text("Created \(lesson.createdAt.formatted(.relative(presentation: .named)))")
            }
        }
    }
}

struct TaskRowView: View {
    let task: TaskSmall

    var body: some View {
        BaseRowView(
            destination: TaskDetailView(taskID: task.id),
            title: task.title,
            seen: task.seen ?? false
        ) {
            if let dueDate = task.dueDate {
                HStack(spacing: 4) {
                    Image(systemName: "calendar")
                    Text("Due \(dueDate, style: .date)")
                }
                .foregroundStyle(isOverdue ? .red : .secondary)
            }
        } trailing: {
            if task.completed {
                StatusBadge(icon: "checkmark.circle.fill", text: "Completed", color: .green)
            } else if isOverdue {
                StatusBadge(icon: "exclamationmark.triangle.fill", text: "Overdue", color: .red)
            }
        }
    }

    private var isOverdue: Bool {
        guard let dueDate = task.dueDate else { return false }
        return dueDate < Date() && !task.completed
    }
}

#Preview {
    DeckRowView(deck: MockData.decks.data[0])
    DeckRowView(deck: MockData.decks.data[1])
    DeckRowView(deck: MockData.decks.data[2])
}
