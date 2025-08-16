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
                Image(systemName: "person.crop.circle")
                    .foregroundStyle(.primary)
            }
            .accessibilityLabel("Settings")
            .accessibilityHint("Access app settings and account options")
        }

        ToolbarItem {
            RefreshButton {
                refreshDashboard()
            }
        }
    }
}
