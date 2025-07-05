import SwiftUI

struct LessonRow: View {
    var lesson: Lesson

    var body: some View {
        NavigationLink(value: lesson) {
            HStack {
                VStack(alignment: .leading) {
                    Text(lesson.topic)
                        .font(.title3)
                    Text("\(lesson.createdAt.formatted(.relative(presentation: .named)))")
                        .foregroundStyle(.secondary)
                }
            }
            .padding(.vertical, 8)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    LessonRow(lesson: Lesson.preview)
}
