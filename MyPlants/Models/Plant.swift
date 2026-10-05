import Foundation

enum Room: String, CaseIterable, Codable, Identifiable {
    case bedroom = "Bedroom"
    case livingRoom = "Living Room"
    case kitchen = "Kitchen"
    case bathroom = "Bathroom"
    case balcony = "Balcony"
    case office = "Office"

    var id: String { rawValue }
}

enum LightLevel: String, CaseIterable, Codable, Identifiable {
    case fullSun = "Full sun"
    case partialSun = "Partial sun"
    case lowLight = "Low light"

    var id: String { rawValue }

    var symbol: String {
        switch self {
        case .fullSun: return "sun.max"
        case .partialSun: return "cloud.sun"
        case .lowLight: return "moon"
        }
    }
}

enum WateringFrequency: String, CaseIterable, Codable, Identifiable {
    case everyDay = "Every day"
    case everyTwoDays = "Every 2 days"
    case everyThreeDays = "Every 3 days"
    case onceAWeek = "Once a week"
    case everyTenDays = "Every 10 days"
    case everyTwoWeeks = "Every 2 weeks"

    var id: String { rawValue }

    /// Gap between waterings, used to schedule the reminder.
    var intervalInDays: Int {
        switch self {
        case .everyDay: return 1
        case .everyTwoDays: return 2
        case .everyThreeDays: return 3
        case .onceAWeek: return 7
        case .everyTenDays: return 10
        case .everyTwoWeeks: return 14
        }
    }
}

enum WaterAmount: String, CaseIterable, Codable, Identifiable {
    case small = "20-50 ml"
    case medium = "50-100 ml"
    case large = "100-200 ml"
    case extraLarge = "200-300 ml"

    var id: String { rawValue }
}

struct Plant: Identifiable, Codable, Hashable {
    var id: UUID = UUID()
    var name: String
    var room: Room = .bedroom
    var light: LightLevel = .fullSun
    var wateringFrequency: WateringFrequency = .everyDay
    var waterAmount: WaterAmount = .small
    var isWatered: Bool = false

    static func blank() -> Plant {
        Plant(name: "")
    }
}
