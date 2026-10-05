import SwiftUI

struct PlantListView: View {
    @EnvironmentObject private var store: PlantStore
    var onSelect: (Plant) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            progressHeader

            Text("Today")
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(Theme.primaryText)
                .padding(.horizontal, 20)
                .padding(.top, 18)
                .padding(.bottom, 2)

            List {
                ForEach(store.plants) { plant in
                    PlantRowView(plant: plant) {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            store.toggleWatered(plant)
                        }
                    }
                    .listRowBackground(Color.clear)
                    .listRowInsets(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                    .listRowSeparatorTint(Theme.separator)
                    .onTapGesture { onSelect(plant) }
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button(role: .destructive) {
                            withAnimation { store.delete(plant) }
                        } label: {
                            Image(systemName: "trash")
                        }
                        .tint(Theme.danger)
                    }
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .background(Theme.background)
            .environment(\.defaultMinListRowHeight, 1)
        }
    }

    private var progressHeader: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(store.headline)
                .font(.system(size: 14))
                .foregroundStyle(Theme.secondaryText)

            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Theme.separator)
                        .frame(height: 2)
                    Capsule()
                        .fill(Theme.mint)
                        .frame(width: geometry.size.width * store.progress, height: 2)
                }
                .frame(height: 2)
            }
            .frame(height: 2)
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .animation(.easeInOut(duration: 0.25), value: store.progress)
    }
}
