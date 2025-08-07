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
        ContentUnavailableView(
            title,
            systemImage: icon,
            description: Text(description),
        )
    }
}

#Preview {
    EmptyStateView(icon: "person.circle", title: "Hello", description: "World")
}
