    //
    //  LessonRowView.swift
    //  Ogonek
    //
    //  Rewritten following Basic Car Maintenance pattern
    //

import SwiftUI
struct LessonRowView: View {
    let lesson: LessonSmall

    var body: some View {
        NavigationLink {
            LessonDetailView(lessonId: lesson.id)
        } label: {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    Text(lesson.topic)
                        .font(.headline)
                        .lineLimit(2)
                        .foregroundColor(.primary)

                    HStack(spacing: 4) {
                        Image(systemName: "clock")
                            .font(.caption2)
                            .foregroundColor(.secondary)

                        Text("Created \(lesson.createdAt.formatted(.relative(presentation: .named)))")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
}

#Preview("Lesson Row View") {
    VStack {
        LessonRowView(lesson: MockData.paginatedLessons.data[0])
            .padding()
            .background(.regularMaterial)
            .cornerRadius(12)

        LessonRowView(lesson: MockData.paginatedLessons.data[1])
            .padding()
            .background(.regularMaterial)
            .cornerRadius(12)
    }
    .padding()
}
