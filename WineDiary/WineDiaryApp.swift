import SwiftUI
import SwiftData

@main
struct WineDiaryApp: App {
    @StateObject private var notificationManager = NotificationManager()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(notificationManager)
        }
        .modelContainer(for: WineEntry.self)
    }
}
