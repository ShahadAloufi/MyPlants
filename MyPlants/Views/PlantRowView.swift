import SwiftUI

struct PlantRowView: View {
    let plant: Plant
    var onToggle: () -> Void

    var body: some View {
        HStack(alignment: .center, spacing: 14) {
            Button(action: onToggle) {
                ZStack {
                    Circle()
                        .strokeBorder(plant.isWatered ? Color.clear : Theme.separator, lineWidth: 1.5)
                        .background(
                            Circle().fill(plant.isWatered ? Theme.mintDeep : Color.clear)
                        )
                        .frame(width: 26, height: 26)

                    if plant.isWatered {
                        Image(systemName: "checkmark")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundStyle(.black)
                    }
                }
            }
            .buttonStyle(.plain)

            VStack(alignment: .leading, spacing: 7) {
                HStack(spacing: 4) {
                    Image(systemName: "location")
                        .font(.system(size: 10, weight: .semibold))
                    Text("in \(plant.room.rawValue)")
                        .font(.system(size: 12))
                }
                .foregroundStyle(Theme.mutedText)

                Text(plant.name)
                    .font(.system(size: 22, weight: .regular))
                    .foregroundStyle(plant.isWatered ? Theme.mutedText : Theme.primaryText)

                HStack(spacing: 8) {
                    InfoChip(
                        symbol: plant.light.symbol,
                        text: plant.light.rawValue,
                        tint: plant.isWatered ? Theme.mutedText : Theme.sunYellow
                    )
                    InfoChip(
                        symbol: "drop",
                        text: plant.waterAmount.rawValue,
                        tint: plant.isWatered ? Theme.mutedText : Theme.waterBlue
                    )
                }
            }

            Spacer(minLength: 0)
        }
        .padding(.vertical, 12)
        .contentShape(Rectangle())
    }
}

#Preview {
    ZStack {
        Theme.background.ignoresSafeArea()
        VStack {
            PlantRowView(plant: Plant(name: "Monstera", room: .kitchen), onToggle: {})
            PlantRowView(
                plant: Plant(name: "Pothos", room: .bedroom, isWatered: true),
                onToggle: {}
            )
        }
        .padding()
    }
    .preferredColorScheme(.dark)
}
