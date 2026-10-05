import SwiftUI

/// Create or edit a single plant reminder.
struct ReminderFormView: View {
    enum Mode {
        case create
        case edit
    }

    @Environment(\.dismiss) private var dismiss
    @FocusState private var nameFocused: Bool

    @State private var plant: Plant
    private let mode: Mode

    var onSave: (Plant) -> Void
    var onDelete: (Plant) -> Void

    init(
        plant: Plant?,
        onSave: @escaping (Plant) -> Void,
        onDelete: @escaping (Plant) -> Void
    ) {
        _plant = State(initialValue: plant ?? Plant.blank())
        self.mode = plant == nil ? .create : .edit
        self.onSave = onSave
        self.onDelete = onDelete
    }

    private var canSave: Bool {
        !plant.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var body: some View {
        ZStack {
            Theme.sheetBackground.ignoresSafeArea()

            VStack(spacing: 0) {
                navigationBar

                ScrollView {
                    VStack(spacing: 16) {
                        nameCard
                        placementCard
                        wateringCard

                        if mode == .edit {
                            deleteCard
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                }
            }
        }
        .preferredColorScheme(.dark)
    }

    // MARK: - Bar

    private var navigationBar: some View {
        ZStack {
            Text("Set Reminder")
                .font(.system(size: 17, weight: .semibold))
                .foregroundStyle(Theme.primaryText)

            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundStyle(Theme.secondaryText)
                        .frame(width: 30, height: 30)
                        .background(Circle().fill(Theme.cardRaised))
                }

                Spacer()

                Button {
                    onSave(plant)
                    dismiss()
                } label: {
                    Image(systemName: "checkmark")
                        .font(.system(size: 13, weight: .bold))
                        .foregroundStyle(.black)
                        .frame(width: 30, height: 30)
                        .background(Circle().fill(canSave ? Theme.mintDeep : Theme.separator))
                }
                .disabled(!canSave)
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 18)
        .padding(.bottom, 14)
        .overlay(alignment: .bottom) {
            Rectangle().fill(Theme.separator).frame(height: 0.6)
        }
    }

    // MARK: - Cards

    private var nameCard: some View {
        HStack(spacing: 12) {
            Text("Plant Name")
                .font(.system(size: 16))
                .foregroundStyle(Theme.primaryText)

            TextField("", text: $plant.name, prompt: Text("Pothos").foregroundColor(Theme.mutedText))
                .font(.system(size: 16))
                .foregroundStyle(Theme.primaryText)
                .focused($nameFocused)
                .submitLabel(.done)
        }
        .padding(.horizontal, 16)
        .frame(height: 50)
        .background(RoundedRectangle(cornerRadius: 12, style: .continuous).fill(Theme.card))
    }

    private var placementCard: some View {
        VStack(spacing: 0) {
            pickerRow(symbol: "location", title: "Room", selection: $plant.room)
            rowDivider
            pickerRow(symbol: "sun.max", title: "Light", selection: $plant.light)
        }
        .background(RoundedRectangle(cornerRadius: 12, style: .continuous).fill(Theme.card))
    }

    private var wateringCard: some View {
        VStack(spacing: 0) {
            pickerRow(symbol: "drop", title: "Watering Days", selection: $plant.wateringFrequency)
            rowDivider
            pickerRow(symbol: "drop", title: "Water", selection: $plant.waterAmount)
        }
        .background(RoundedRectangle(cornerRadius: 12, style: .continuous).fill(Theme.card))
    }

    private var deleteCard: some View {
        Button(role: .destructive) {
            onDelete(plant)
            dismiss()
        } label: {
            Text("Delete Reminder")
                .font(.system(size: 16))
                .foregroundStyle(Theme.danger)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(RoundedRectangle(cornerRadius: 12, style: .continuous).fill(Theme.card))
        }
    }

    private var rowDivider: some View {
        Rectangle()
            .fill(Theme.separator)
            .frame(height: 0.6)
            .padding(.leading, 16)
    }

    /// One "icon · label ············ value ⌃⌄" row backed by a menu picker.
    private func pickerRow<T: Hashable & Identifiable & CaseIterable & RawRepresentable>(
        symbol: String,
        title: String,
        selection: Binding<T>
    ) -> some View where T.RawValue == String, T.AllCases: RandomAccessCollection {
        HStack(spacing: 10) {
            Image(systemName: symbol)
                .font(.system(size: 14))
                .foregroundStyle(Theme.secondaryText)
                .frame(width: 18)

            Text(title)
                .font(.system(size: 16))
                .foregroundStyle(Theme.primaryText)

            Spacer()

            Menu {
                Picker(title, selection: selection) {
                    ForEach(T.allCases) { option in
                        Text(option.rawValue).tag(option)
                    }
                }
            } label: {
                HStack(spacing: 6) {
                    Text(selection.wrappedValue.rawValue)
                        .font(.system(size: 16))
                        .foregroundStyle(Theme.secondaryText)
                    Image(systemName: "chevron.up.chevron.down")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundStyle(Theme.mutedText)
                }
            }
        }
        .padding(.horizontal, 16)
        .frame(height: 50)
    }
}

#Preview {
    ReminderFormView(plant: nil, onSave: { _ in }, onDelete: { _ in })
}
