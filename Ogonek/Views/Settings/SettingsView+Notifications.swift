//
//  SettingsView+Notifications.swift
//  Ogonek
//
//  Created by Danila Volkov on 21.08.2025.
//

import SwiftUI

extension SettingsView {
    var notificationSection: some View {
        Section(
            footer: Text("The Telegram toggle will only work if you have sent a message [to this bot](https://t.me/fz_notif_bot).")
        ) {
            Button {
                if pushTokenStore.isAuthorized {
                    openAppSettings()
                } else {
                    viewModel.requestNotificationPermission()
                }
            } label: {
                VStack(alignment: .leading, spacing: 2) {
                    HStack {
                        Text("Push Notifications")
                            .font(.body)
                        Spacer()
                        Text(pushTokenStore.isAuthorized ? "Enabled" : "Disabled")
                            .font(.caption)
                            .foregroundStyle(pushTokenStore.isAuthorized ? .green : .secondary)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 2)
                            .background(
                                Capsule()
                                    .fill(pushTokenStore.isAuthorized ? .green.opacity(0.1) : .gray.opacity(0.1))
                            )
                    }
                }
            }
            .buttonStyle(.plain)

            Toggle("Telegram", isOn: $telegramUpdates)
        }
    }
}
