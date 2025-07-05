//
//  Tag.swift
//  Ogonek
//
//  Created by Danila Volkov on 05.07.2025.
//

import SwiftUI

struct Tag: View {
    var tag: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(tag)
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(Color.secondary.opacity(0.1))
                .clipShape(Capsule())
        }
    }
}

#Preview {
    Tag(tag: "Hello")
}
