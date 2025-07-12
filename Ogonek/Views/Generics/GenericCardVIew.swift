//
//  GenericCardVIew.swift
//  Ogonek
//
//  Created by Danila Volkov on 12.07.2025.
//

import SwiftUI

// MARK: - Generic Clickable Card Component
struct GenericCardVIew<Content: View>: View {
    let content: Content
    let action: () -> Void

        // Styling properties
    let backgroundColor: Color
    let cornerRadius: CGFloat
    let shadowRadius: CGFloat
    let borderColor: Color
    let borderWidth: CGFloat

    init(
        backgroundColor: Color = Color(.systemBackground),
        cornerRadius: CGFloat = 12,
        shadowRadius: CGFloat = 2,
        borderColor: Color = Color(.systemGray4),
        borderWidth: CGFloat = 1,
        action: @escaping () -> Void,
        @ViewBuilder content: () -> Content
    ) {
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.shadowRadius = shadowRadius
        self.borderColor = borderColor
        self.borderWidth = borderWidth
        self.action = action
        self.content = content()
    }

    var body: some View {
        Button(action: action) {
            content
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(backgroundColor)
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .stroke(borderColor, lineWidth: borderWidth)
                )
                .cornerRadius(cornerRadius)
                .shadow(color: Color.black.opacity(0.1), radius: shadowRadius, x: 0, y: 1)
        }
        .buttonStyle(PlainButtonStyle())
        .scaleEffect(1.0)
        .animation(.easeInOut(duration: 0.15), value: 1.0)
    }
}
