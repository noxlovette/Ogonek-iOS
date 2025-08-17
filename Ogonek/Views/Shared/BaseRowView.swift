import SwiftUI

    /// A reusable row layout with a title, optional unread dot, subtitle, and trailing content.
struct BaseRowView<Destination: View, Trailing: View, Subtitle: View>: View {
    let destination: Destination
    let title: String
    let seen: Bool
    let subtitle: Subtitle
    let trailing: Trailing

    init(
        destination: Destination,
        title: String,
        seen: Bool = true,
        @ViewBuilder subtitle: () -> Subtitle,
        @ViewBuilder trailing: () -> Trailing = { EmptyView() }
    ) {
        self.destination = destination
        self.title = title
        self.seen = seen
        self.subtitle = subtitle()
        self.trailing = trailing()
    }

    var body: some View {
        NavigationLink {
            destination
        } label: {
            HStack(alignment: .top, spacing: 12) {
                VStack(alignment: .leading, spacing: 6) {
                        // Title + unread dot
                    HStack(alignment: .top, spacing: 8) {
                        Text(title)
                            .font(.subheadline)
                            .lineLimit(2)
                            .foregroundStyle(.primary)
                            .multilineTextAlignment(.leading)

                        if !seen {
                            Circle()
                                .fill(.red)
                                .frame(width: 6, height: 6)
                        }

                        Spacer()
                    }

                    subtitle
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Spacer()
                trailing
            }
            .padding(.vertical, 8)
        }
        .buttonStyle(.plain)
    }
}
