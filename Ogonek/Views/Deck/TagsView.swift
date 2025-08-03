//
//  TagsView.swift
//  Ogonek
//
//  Created by Danila Volkov on 05.07.2025.
//

import SwiftUI

// MARK: - Tags View Component

struct TagsView: View {
    let tags: [String]

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 6) {
                ForEach(tags.prefix(3), id: \.self) { tag in
                    Text(tag.trimmingCharacters(in: .whitespacesAndNewlines))
                        .font(.caption2)
                        .fontWeight(.medium)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(
                            Capsule()
                        )
                }

                if tags.count > 3 {
                    Text("+\(tags.count - 3)")
                        .font(.caption2)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(
                            Capsule()
                        )
                }
            }
            .padding(.horizontal, 1)
        }
    }
}
