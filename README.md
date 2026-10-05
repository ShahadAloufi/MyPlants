# My Plants 🌱

A SwiftUI plant-watering reminder app for iOS.

## Running it

1. Unzip and double-click `MyPlants.xcodeproj`.
2. Pick any iPhone simulator in the toolbar and press ⌘R.

Requires Xcode 16 or newer. Deployment target is iOS 17.0.
Signing is set to automatic with no team — for a physical device, select your
own team under **Signing & Capabilities** and change the bundle identifier
from `com.example.MyPlants`.

## Screens

| Screen | Where |
| --- | --- |
| Start your plant journey | `Views/StartJourneyView.swift` |
| Set Reminder sheet (create + edit + delete) | `Views/ReminderFormView.swift` |
| Today's list with progress header | `Views/PlantListView.swift`, `Views/PlantRowView.swift` |
| All Done 🎉 | `Views/AllDoneView.swift` |
| Smiling plant illustration | `Views/PlantMascotView.swift` |

## How it works

- `Models/Plant.swift` — the plant record plus the picker options
  (room, light, watering days, water amount).
- `Store/PlantStore.swift` — single source of truth, persisted to
  `UserDefaults` as JSON so reminders survive relaunches.
- `Store/NotificationManager.swift` — schedules a repeating local
  notification per plant ("Hey! Let's water your plant 💦"). Permission is
  requested the first time a reminder is created, not on launch.
- `Theme.swift` — the palette and the shared header / chip components.

Tap a row's circle to mark it watered; the header progress bar fills as you
go, and the All Done screen takes over once everything is checked. Tap a row
to edit it, or swipe left to delete.
