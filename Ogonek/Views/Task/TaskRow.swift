/*
 See LICENSE folder for this sample’s licensing information.

 Abstract:
 The list item view which displays details of a given earthquake.
 */

import SwiftUI

struct TaskRow: View {
    var task: Assignment

    var body: some View {
        NavigationLink(value: task) {
            HStack {
                VStack(alignment: .leading) {
                    Text(task.title)
                        .font(.title3)
                    Text("\(task.createdAt.formatted(.relative(presentation: .named)))")
                        .foregroundStyle(.secondary)
                }
            }
            .padding(.vertical, 8)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    TaskRow(task: Assignment.preview)
}
