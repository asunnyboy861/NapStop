import SwiftUI
import SwiftData

@main
struct NapStopApp: App {
    @State private var selectedTab = 0
    @State private var showSearch = false

    var body: some Scene {
        WindowGroup {
            MainTabView(selectedTab: $selectedTab, showSearch: $showSearch)
                .onOpenURL { url in
                    switch url.host {
                    case "search":
                        selectedTab = 0
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            showSearch = true
                        }
                    case "history":
                        selectedTab = 1
                    case "settings":
                        selectedTab = 2
                    default:
                        break
                    }
                }
        }
        .modelContainer(for: [AlarmDestination.self, AlarmRecord.self])
    }
}
