import Foundation
import SwiftUI

@MainActor
final class PlantStore: ObservableObject {
    @Published private(set) var plants: [Plant] = []

    private let storageKey = "my-plants.reminders.v1"

    init() {
        load()
    }

    // MARK: - Derived state

    var wateredCount: Int {
        plants.filter(\.isWatered).count
    }

    var isEmpty: Bool {
        plants.isEmpty
    }

    var allRemindersCompleted: Bool {
        !plants.isEmpty && wateredCount == plants.count
    }

    var progress: Double {
        guard !plants.isEmpty else { return 0 }
        return Double(wateredCount) / Double(plants.count)
    }

    var headline: String {
        if allRemindersCompleted {
            return "All your plants feel loved today 🌿"
        }
        if wateredCount > 0 {
            return "\(wateredCount) of your plants feel loved today 🌿"
        }
        return "Your plants are waiting for a sip 💦"
    }

    // MARK: - Mutations

    func add(_ plant: Plant) {
        // Ask for notification permission in context: the first time a
        // reminder is actually created, not on a cold launch.
        if plants.isEmpty {
            NotificationManager.requestAuthorization()
        }
        var new = plant
        new.name = plant.name.trimmingCharacters(in: .whitespacesAndNewlines)
        plants.append(new)
        NotificationManager.schedule(for: new)
        save()
    }

    func update(_ plant: Plant) {
        guard let index = plants.firstIndex(where: { $0.id == plant.id }) else { return }
        var updated = plant
        updated.name = plant.name.trimmingCharacters(in: .whitespacesAndNewlines)
        plants[index] = updated
        NotificationManager.schedule(for: updated)
        save()
    }

    func delete(_ plant: Plant) {
        plants.removeAll { $0.id == plant.id }
        NotificationManager.cancel(for: plant)
        save()
    }

    func delete(at offsets: IndexSet) {
        for index in offsets {
            NotificationManager.cancel(for: plants[index])
        }
        plants.remove(atOffsets: offsets)
        save()
    }

    func toggleWatered(_ plant: Plant) {
        guard let index = plants.firstIndex(where: { $0.id == plant.id }) else { return }
        plants[index].isWatered.toggle()
        save()
    }

    /// Starts a fresh day: every reminder goes back to unchecked.
    func startNewDay() {
        for index in plants.indices {
            plants[index].isWatered = false
        }
        save()
    }

    // MARK: - Persistence

    private func save() {
        guard let data = try? JSONEncoder().encode(plants) else { return }
        UserDefaults.standard.set(data, forKey: storageKey)
    }

    private func load() {
        guard
            let data = UserDefaults.standard.data(forKey: storageKey),
            let decoded = try? JSONDecoder().decode([Plant].self, from: data)
        else { return }
        plants = decoded
    }
}
