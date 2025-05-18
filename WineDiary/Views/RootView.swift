import SwiftUI

struct RootView: View {
    @EnvironmentObject var notificationManager: NotificationManager

    var body: some View {
        NavigationStack {
            ZStack {
                WineListView()
                if let notification = notificationManager.notification {
                    VStack {
                        NotificationBannerView(notification: notification)
                            .transition(.move(edge: .top).combined(with: .opacity))
                            .zIndex(1)
                        Spacer()
                    }
                    .animation(.easeInOut(duration: 0.3), value: notification.id)
                }
            }
        }
        .toolbarBackground(Color.wineRed, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .accentColor(.white)
    }
}
