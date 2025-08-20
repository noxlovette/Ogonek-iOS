import SwiftUI

struct DownloadButton: View {
    var action: () -> Void = {}

    var body: some View {
        Button(action: action) {
            Label("Download", systemImage: "arrow.down")
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    RefreshButton()
}
