/*
 See LICENSE folder for this sample’s licensing information.
 */

import SwiftUI

struct ToolbarStatus: View {
    var isLoading: Bool
    var lastUpdated: TimeInterval
    var lessonsCount: Int

    var body: some View {
        VStack {
            if isLoading {
                Text("Checking for Lessons...")
                Spacer()
            } else if lastUpdated == Date.distantFuture.timeIntervalSince1970 {
                Spacer()
                Text("\(lessonsCount) Lessons")
                    .foregroundStyle(Color.secondary)
            } else {
                let lastUpdatedDate = Date(timeIntervalSince1970: lastUpdated)
                Text("Updated \(lastUpdatedDate.formatted(.relative(presentation: .named)))")
                Text("\(lessonsCount) Lessons")
                    .foregroundStyle(Color.secondary)
            }
        }
        .font(.caption)
    }
}

#Preview(traits: .fixedLayout(width: 200, height: 40)) {
    ToolbarStatus(
        isLoading: true,
        lastUpdated: Date.distantPast.timeIntervalSince1970,
        lessonsCount: 125
    )

    ToolbarStatus(
        isLoading: false,
        lastUpdated: Date.distantFuture.timeIntervalSince1970,
        lessonsCount: 10000
    )

    ToolbarStatus(
        isLoading: false,
        lastUpdated: Date.now.timeIntervalSince1970,
        lessonsCount: 10000
    )

    ToolbarStatus(
        isLoading: false,
        lastUpdated: Date.distantPast.timeIntervalSince1970,
        lessonsCount: 10000
    )
}
