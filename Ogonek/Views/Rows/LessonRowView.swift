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
            LessonDetailView(lessonID: lesson.id)
        } label: {
            HStack(alignment: .top, spacing: 12) {
                VStack(alignment: .leading, spacing: 6) {
                        // Topic and unread indicator
                    HStack(alignment: .top, spacing: 8) {
                        Text(lesson.topic)
                            .font(.headline)
                            .lineLimit(2)
                            .foregroundStyle(.primary)
                            .multilineTextAlignment(.leading)

                        Spacer()

                        if !(lesson.seen ?? false) {
                            Circle()
                                .fill(.red)
                                .frame(width: 8, height: 8)
                        }
                    }

                        // Creation date
                    HStack(spacing: 4) {
                        Image(systemName: "clock")
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                        Text("Created \(lesson.createdAt.formatted(.relative(presentation: .named)))")
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    LessonRowView(lesson: MockData.paginatedLessons.data[0])
}
