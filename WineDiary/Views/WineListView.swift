import SwiftUI
import SwiftData

struct WineListView: View {
    @EnvironmentObject var notificationManager: NotificationManager
    
    @Environment(\.modelContext) private var context
    @Query(sort: \WineEntry.dateAdded, order: .reverse) private var wines: [WineEntry]

    @State private var showingAddWine = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(wines) { wine in
                    NavigationLink(destination: WineDetailsView(wine: wine)) {
                        VStack(alignment: .leading) {
                            Text(wine.displayNameWithYear)
                                .font(.headline)
                            StarRatingView(rating: wine.rating)
                                .font(.caption)
                        }
                    }
                }
            }
            .toolbarBackground(Color.wineRed, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Wine Diary")
                        .font(.wineTitle)
                        .foregroundColor(.white)
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddWine = true
                    } label: {
                        Label("Add Wine", systemImage: "plus")
                    }
                    .tint(.white)
                }
            }
            .sheet(isPresented: $showingAddWine) {
                AddWineView()
                    .environmentObject(notificationManager)
            }
        }
    }
}
