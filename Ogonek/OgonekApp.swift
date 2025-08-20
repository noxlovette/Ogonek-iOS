import Sentry
import SwiftUI

@main
struct Ogonek: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    init() {
        let dsn = "https://f6266ebea7566596d2e3ea95739037dc@o4507272574468096.ingest.de.sentry.io/4509665650737232"

        SentrySDK.start { options in
            options.dsn = dsn
            options.debug = true
            options.sendDefaultPii = true
            options.tracesSampleRate = 1.0
            options.configureProfiling = {
                $0.sessionSampleRate = 1.0
                $0.lifecycle = .trace
            }
            options.attachScreenshot = true
            options.attachViewHierarchy = true
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(APIService.shared)
                .environment(appDelegate)
                .environment(AppState.shared)
        }
    }
}
