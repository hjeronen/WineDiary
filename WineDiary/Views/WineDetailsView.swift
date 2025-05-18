import SwiftUI
import SwiftData

struct WineDetailsView: View {
    @EnvironmentObject var notificationManager: NotificationManager
    
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var showingDeleteConfirmation = false
    
    let wine: WineEntry
    
    @State private var isEditing = false

    // Temporary fields for editing
    @State private var name: String = ""
    @State private var year: Int = 0
    @State private var rating: Double = 0.0

    var body: some View {
        Form {
            if isEditing {
                WineForm(name: $name, year: $year, rating: $rating)
            } else {
                Section(header: Text("Wine Details")) {
                    Text(wine.name)
                    Text("Year: \(wine.year.description)")
                    StarRatingView(rating: wine.rating)
                }
            }

            Section(header: Text("Added On")) {
                Text(wine.dateAdded.formatted(date: .abbreviated, time: .omitted))
            }
        }
        .onAppear {
            name = wine.name
            year = wine.year
            rating = wine.rating
        }
        .toolbarBackground(Color.wineRed, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Text(wine.displayNameWithYear)
                    .font(.wineTitle)
                    .foregroundColor(.white)
            }
            if isEditing {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        name = wine.name
                        year = wine.year
                        rating = wine.rating
                        isEditing = false
                    } label: {
                        Image(systemName: "xmark")
                    }
                    .tint(.white)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        updateWine()
                    } label: {
                        Image(systemName: "checkmark")
                    }
                    .tint(name.isEmpty || year == 0 ? .gray : .white)
                    .disabled(name.isEmpty || year == 0)
                }
            } else {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        isEditing = true
                    } label: {
                        Image(systemName: "pencil")
                    }
                    .tint(.white)
                }
            }
            ToolbarItem(placement: .destructiveAction) {
                Button(role: .destructive) {
                    showingDeleteConfirmation = true
                } label: {
                    Image(systemName: "trash")
                }
                .tint(.white)
            }
        }
        .alert("Delete Wine", isPresented: $showingDeleteConfirmation, actions: {
            Button("Delete", role: .destructive) {
                deleteWine()
            }
            Button("Cancel", role: .cancel) { }
        }, message: {
            Text("This will permanently remove the wine from your diary.")
        })
    }
    
    private func updateWine() {
        wine.name = name
        wine.year = year
        wine.rating = rating

        do {
            try context.save()
            notificationManager.show("Updated entry", type: .success)
            isEditing = false
        } catch {
            notificationManager.show("Failed to update entry", type: .error)
        }
    }
    
    private func deleteWine() {
        context.delete(wine)
        
        do {
            try context.save()
            notificationManager.show("Wine deleted!", type: .success)
            dismiss()
        } catch {
            print("Failed to delete wine: \(error.localizedDescription)")
            notificationManager.show("Failed to delete wine.", type: .error)
            dismiss()
        }
    }
}
