import MarkdownUI
import SwiftUI

// MARK: - Main View

struct LessonDetailView: View {
    let lesson: Lesson

    @State private var showingTableOfContents = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                VStack(alignment: .leading, spacing: 12) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(lesson.topic)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                    }

                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                }

                Divider()
                    .padding(.vertical, 16)

                HStack(alignment: .top, spacing: 16) {
                    Markdown(lesson.markdown)
                }
                .padding(.horizontal, 16)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Preview

struct LessonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LessonDetailView(
                lesson: Lesson.preview,
            )
        }
    }
}
