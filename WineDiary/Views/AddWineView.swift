import SwiftUI
import SwiftData

struct AddWineView: View {
    @EnvironmentObject var notificationManager: NotificationManager
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    var availableYears: [Int] {
        let currentYear = Calendar.current.component(.year, from: Date())
        return Array((1500...currentYear).reversed())
    }

    @State private var name = ""
    @State private var year = Calendar.current.component(.year, from: Date())
    @State private var rating = 3.5
    
    var isValid: Bool {
        !name.isEmpty && year != 0
    }

    var body: some View {
        NavigationStack {
            Form {
                WineForm(name: $name, year: $year, rating: $rating)
            }
            .toolbarBackground(Color.wineRed, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Add Wine")
                        .font(.wineTitle)
                        .foregroundColor(.white)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                    .tint(.white)
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        let newWine = WineEntry(name: name, year: year, rating: rating)
                        context.insert(newWine)

                        do {
                            try context.save()
                            notificationManager.show("Wine added!", type: .success)
                            dismiss()
                        } catch {
                            notificationManager.show("Failed to save wine.", type: .error)
                            dismiss()
                        }
                    } label: {
                        Image(systemName: "checkmark")
                    }
                    .tint(isValid ? .white : .gray)
                    .disabled(!isValid)
                }
            }
        }
    }
}
