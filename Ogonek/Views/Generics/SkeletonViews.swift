//
//  SkeletonViews.swift
//  Ogonek
//
//  Created by Danila Volkov on 04.08.2025.
//

import SwiftUI

struct SkeletonRows: View {
    var body: some View {
        LazyVStack(spacing: 8) {
            ForEach(0 ..< 3, id: \.self) { _ in
                SkeletonRow()
            }
        }
    }
}

struct SkeletonRow: View {
    let height: CGFloat

    init(height: CGFloat = 60) {
        self.height = height
    }

    var body: some View {
        Rectangle()
            .fill(Color.gray.opacity(0.2))
            .frame(height: height)
            .cornerRadius(8)
            .redacted(reason: .placeholder)
    }
}

#Preview {
    SkeletonRows()
}
