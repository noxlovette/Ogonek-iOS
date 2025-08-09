//
//  EmptyStateView.swift
//  Ogonek
//
//  Created by Danila Volkov on 04.08.2025.
//

import SwiftUI

struct EmptyStateView: View {
    let icon: String
    let title: String
    let description: String

    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 48))
                .foregroundStyle(.tertiary)
                .symbolRenderingMode(.hierarchical)
                .scaleEffect(1.0)
                .animation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true), value: UUID())

            VStack(spacing: 8) {
                Text(title)
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundStyle(.primary)

                Text(description)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 24)
    }
}

#Preview {
    EmptyStateView(icon: "person.circle", title: "Hello", description: "World")
}
