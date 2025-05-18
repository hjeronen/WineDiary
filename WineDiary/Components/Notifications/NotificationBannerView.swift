import SwiftUI

struct NotificationBannerView: View {
    let notification: AppNotification

    var backgroundColor: Color {
        switch notification.type {
        case .success: return .green.opacity(0.85)
        case .error: return .red.opacity(0.85)
        }
    }

    var body: some View {
        Text(notification.message)
            .font(.subheadline)
            .padding(.vertical, 10)
            .padding(.horizontal, 20)
            .background(backgroundColor)
            .foregroundColor(.white)
            .cornerRadius(12)
            .shadow(radius: 4)
            .padding(.horizontal)
    }
}
