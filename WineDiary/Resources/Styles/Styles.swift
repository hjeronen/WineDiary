import SwiftUI

// MARK: - Color Palette
extension Color {
    static let wineRed = Color(red: 120/255, green: 40/255, blue: 60/255)
    static let grapeGray = Color(red: 50/255, green: 50/255, blue: 60/255)
    static let vineyardGold = Color(red: 210/255, green: 180/255, blue: 140/255)
    static let backgroundBeige = Color(red: 250/255, green: 245/255, blue: 235/255)
}

// MARK: - Typography
extension Font {
    static let wineTitle = Font.system(size: 24, weight: .bold, design: .serif)
    static let wineBody = Font.system(size: 17, weight: .regular, design: .default)
    static let wineCaption = Font.system(size: 14, weight: .light, design: .rounded)
}

// MARK: - Button Style
struct WineButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.wineBody)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(Color.wineRed)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .opacity(configuration.isPressed ? 0.85 : 1.0)
    }
}

// MARK: - Layout Constants
enum WineStyle {
    static let cornerRadius: CGFloat = 12
    static let padding: CGFloat = 16
}
