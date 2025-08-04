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
    let subtitle: String

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title)
                .foregroundColor(.secondary)

            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)

            Text(subtitle)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .cornerRadius(12)
    }
}

#Preview {
    EmptyStateView(icon: "person.circle", title: "Hello", subtitle: "World")
}
