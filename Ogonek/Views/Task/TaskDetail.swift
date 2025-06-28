//
//  LessonDetail.swift
//  Ogonek
//
//  Created by Danila Volkov on 29.04.2025.
//
import MarkdownUI
import SwiftUI

struct TaskDetail: View {
    let task: Assignment

    var body: some View {
        ScrollView {
            VStack {
                Markdown(task.markdown)
                    .padding(.top, 8)

                Spacer()
            }
            .padding()
            .navigationTitle(task.title)
        }
    }
}

#Preview {
    NavigationView {
        TaskDetail(task: Assignment.preview)
    }
}
