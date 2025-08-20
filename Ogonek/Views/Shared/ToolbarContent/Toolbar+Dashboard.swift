//
//  Toolbar+Dashboard.swift
//  Ogonek
//
//  Created by Danila Volkov on 09.08.2025.
//

import SwiftUI

extension DashboardView {
    @ToolbarContentBuilder
    func toolbarContent() -> some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            NavigationLink {
                SettingsView()
            } label: {
                Label("Settings", systemImage: "person.crop.circle")
                    .foregroundStyle(.primary)
            }
            .accessibilityLabel("Settings")
            .accessibilityHint("Access app settings and account options")
        }

        ToolbarItem(placement: .topBarTrailing) {
            RefreshButton {
                refreshDashboard()
            }
        }
    }
}
