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
            Button {
                logout()
            } label: {
                Image(systemName: "rectangle.portrait.and.arrow.right")
            }
        }

        ToolbarItem {
            RefreshButton {
                refreshDashboard()
            }
        }
    }
}
