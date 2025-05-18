import SwiftUI

struct WineForm: View {
    @Binding var name: String
    @Binding var year: Int
    @Binding var rating: Double
    
    var availableYears: [Int] {
        let currentYear = Calendar.current.component(.year, from: Date())
        return Array((1500...currentYear).reversed())
    }

    var body: some View {
        Section(header: Text("Wine Details")) {
            TextField("Wine Name", text: $name)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .keyboardType(.default)

            Picker("Year", selection: $year) {
                ForEach(availableYears, id: \.self) { year in
                    Text(String(year)).tag(year)
                }
            }

            Section(header: Text("Rating")) {
                VStack(alignment: .leading, spacing: 6) {
                    StarRatingView(rating: rating)
                    Text(String(format: "%.1f/5", rating))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Slider(value: $rating, in: 1...5, step: 0.5)
                }
            }
        }
    }
}
