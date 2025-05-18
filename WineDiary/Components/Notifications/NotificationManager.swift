import SwiftUI
import Combine

@MainActor
class NotificationManager: ObservableObject {
    @Published var notification: AppNotification?

    private var dismissTask: Task<Void, Never>?

    func show(_ message: String, type: NotificationType = .success, duration: TimeInterval = 2.5) {
        notification = AppNotification(message: message, type: type)

        dismissTask?.cancel()
        dismissTask = Task {
            try? await Task.sleep(nanoseconds: UInt64(duration * 1_000_000_000))
            notification = nil
        }
    }
}
