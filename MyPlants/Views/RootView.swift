import SwiftUI

struct RootView: View {
    @EnvironmentObject private var store: PlantStore

    @State private var editingPlant: Plant?
    @State private var isCreating = false

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Theme.background.ignoresSafeArea()

            VStack(spacing: 0) {
                ScreenHeader()
                    .padding(.top, 8)

                if store.isEmpty {
                    StartJourneyView { isCreating = true }
                } else if store.allRemindersCompleted {
                    AllDoneView()
                } else {
                    PlantListView { plant in editingPlant = plant }
                }
            }

            if !store.isEmpty {
                addButton
                    .padding(.trailing, 24)
                    .padding(.bottom, 28)
            }
        }
        .sheet(isPresented: $isCreating) {
            ReminderFormView(
                plant: nil,
                onSave: { store.add($0) },
                onDelete: { _ in }
            )
        }
        .sheet(item: $editingPlant) { plant in
            ReminderFormView(
                plant: plant,
                onSave: { store.update($0) },
                onDelete: { store.delete($0) }
            )
        }
    }

    private var addButton: some View {
        Button {
            isCreating = true
        } label: {
            Image(systemName: "plus")
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(.black)
                .frame(width: 50, height: 50)
                .background(Circle().fill(Theme.mint))
                .shadow(color: .black.opacity(0.4), radius: 8, y: 4)
        }
        .accessibilityLabel("Add a plant reminder")
    }
}

#Preview {
    RootView()
        .environmentObject(PlantStore())
        .preferredColorScheme(.dark)
}
