//
//  OgonekApp.swift
//  Ogonek Swift
//
//  Created by Nox Lovette on 17.04.2025.
//
import Sentry
import SwiftUI

@main
struct Ogonek: App {
    init() {
        // MARK: Set up Sentry

        SentrySDK.start { options in
            options.dsn = "https://f6266ebea7566596d2e3ea95739037dc@o4507272574468096.ingest.de.sentry.io/4509665650737232"
            options.debug = true // Enabled debug when first installing is always helpful
            // Adds IP for users.
            // For more information, visit: https://docs.sentry.io/platforms/apple/data-management/data-collected/
            options.sendDefaultPii = true
            // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
            options.tracesSampleRate = 1.0
            // Configure profiling. Visit https://docs.sentry.io/platforms/apple/profiling/ to learn more.
            options.configureProfiling = {
                $0.sessionSampleRate = 1.0 // We recommend adjusting this value in production.
                $0.lifecycle = .trace
            }
            options.attachScreenshot = true // This adds a screenshot to the error events
            options.attachViewHierarchy = true // This adds the view hierarchy to the error events
        }
    }

    @StateObject var apiService = APIService()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
