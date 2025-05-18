import Foundation
import SwiftData

@Model
class WineEntry {
    var name: String
    var year: Int
    var rating: Double
    var dateAdded: Date

    init(name: String, year: Int, rating: Double, dateAdded: Date = .now) {
        self.name = name
        self.year = year
        self.rating = rating
        self.dateAdded = dateAdded
    }
}

extension WineEntry {
    var formattedRating: String {
        rating.formatted(.number.precision(.fractionLength(1)))
    }
    
    var displayNameWithYear: String {
        "\(name) \(year)"
    }
}
