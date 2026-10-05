import SwiftUI

@main
struct MyPlantsApp: App {
    @StateObject private var store = PlantStore()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(store)
                .preferredColorScheme(.dark)
        }
    }
}
