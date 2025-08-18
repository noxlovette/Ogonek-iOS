//
//  LoadingOverlay.swift
//  Ogonek
//
//  Created by Danila Volkov on 18.08.2025.
//

import SwiftUI

struct LoadingOverlay: View {
    var body: some View {
        ProgressView("Loading…")
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(16)
            .frame(width: 220)
    }
}

#Preview {
    LoadingOverlay()
}
