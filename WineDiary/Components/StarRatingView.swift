import SwiftUI

struct StarRatingView: View {
    var rating: Double
    var maximumRating: Int = 5
    var color: Color = .yellow

    var body: some View {
        HStack(spacing: 2) {
            ForEach(1...maximumRating, id: \.self) { index in
                let symbolName = symbol(for: index)
                Image(systemName: symbolName)
                    .foregroundColor(color)
            }
        }
    }

    private func symbol(for index: Int) -> String {
        if rating >= Double(index) {
            return "star.fill"
        } else if rating >= Double(index) - 0.5 {
            return "star.leadinghalf.filled"
        } else {
            return "star"
        }
    }
}
