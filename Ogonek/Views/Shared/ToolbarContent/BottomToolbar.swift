//  BottomToolbar.swift
//  Ogonek
//
//  Created by Danila Volkov on 09.08.2025.
//

import SwiftUI

struct BottomToolbar<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        HStack(spacing: 16) {
            content
        }
        .padding()
        .background(.regularMaterial, ignoresSafeAreaEdges: .bottom)
    }
}

// MARK: - Convenience Modifiers

extension BottomToolbar {
    /// Apply equal width distribution to buttons within the toolbar
    func equalWidthButtons() -> some View {
        modifier(EqualWidthButtonModifier())
    }
}

// MARK: - Helper Modifier for Equal Width Buttons

private struct EqualWidthButtonModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity)
    }
}

// MARK: - Preview

#Preview {
    VStack {
        Spacer()

        // Example usage 1: Multiple buttons with equal width
        BottomToolbar {
            Button(action: {}) {
                HStack(spacing: 8) {
                    Image(systemName: "arrow.down.circle.fill")
                    Text("Download")
                }
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)

            Button(action: {}) {
                HStack(spacing: 8) {
                    Image(systemName: "checkmark.circle.fill")
                    Text("Complete")
                }
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
            .tint(.green)
        }

        // Example usage 2: Single button
        BottomToolbar {
            Button(action: {}) {
                Text("Save Changes")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)
        }

        // Example usage 3: Mixed content
        BottomToolbar {
            Button(action: {}) {
                Image(systemName: "heart")
            }
            .buttonStyle(.bordered)

            Button(action: {}) {
                Text("Primary Action")
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.borderedProminent)

            Button(action: {}) {
                Image(systemName: "ellipsis")
            }
            .buttonStyle(.bordered)
        }
    }
}
