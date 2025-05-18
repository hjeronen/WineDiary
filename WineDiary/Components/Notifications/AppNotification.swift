import Foundation

enum NotificationType {
    case success
    case error
}

struct AppNotification: Identifiable {
    let id = UUID()
    let message: String
    let type: NotificationType
}
