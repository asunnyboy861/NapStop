import SwiftUI
import SwiftData

@main
struct NapStopApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
        .modelContainer(for: [AlarmDestination.self, AlarmRecord.self])
    }
}
