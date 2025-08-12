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
        ToolbarItem {
            RefreshButton {
                refreshDashboard()
            }
        }

        ToolbarItemGroup(placement: .bottomBar) {
            Spacer()

            NavigationLink {
                LearnView()
            } label: {
                ZStack {
                    Circle()
                        .fill(Color.accentColor)
                        .frame(width: 60, height: 60)

                    Image(systemName: "brain.head.profile")
                        .foregroundColor(.white)
                        .font(.system(size: 24))
                }
            }
            .buttonStyle(.plain)

            Spacer()
        }
    }
}
