import Foundation
import UserNotifications

/// Local "Hey! Let's water your plant" reminders.
enum NotificationManager {
    static func requestAuthorization() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge]) { _, _ in }
    }

    static func schedule(for plant: Plant) {
        cancel(for: plant)

        let content = UNMutableNotificationContent()
        content.title = plant.name.isEmpty ? "Your plant" : plant.name
        content.body = "Hey! Let's water your plant 💦"
        content.sound = .default

        let trigger: UNNotificationTrigger
        if plant.wateringFrequency == .everyDay {
            // Every morning at 9:41.
            var components = DateComponents()
            components.hour = 9
            components.minute = 41
            trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        } else {
            let seconds = TimeInterval(plant.wateringFrequency.intervalInDays) * 24 * 60 * 60
            trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: true)
        }

        let request = UNNotificationRequest(
            identifier: plant.id.uuidString,
            content: content,
            trigger: trigger
        )
        UNUserNotificationCenter.current().add(request)
    }

    static func cancel(for plant: Plant) {
        UNUserNotificationCenter.current()
            .removePendingNotificationRequests(withIdentifiers: [plant.id.uuidString])
    }
}
