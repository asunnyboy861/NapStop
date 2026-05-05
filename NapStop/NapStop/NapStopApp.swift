import SwiftUI
import SwiftData

@main
struct NapStopApp: App {
    @State private var selectedTab = 0
    @State private var showSearch = false

    init() {
        let args = ProcessInfo.processInfo.arguments
        if let idx = args.firstIndex(of: "--screenshot-tab"), idx + 1 < args.count,
           let tab = Int(args[idx + 1]) {
            _selectedTab = State(initialValue: tab)
        }
        if args.contains("--show-search") {
            _showSearch = State(initialValue: true)
        }
    }

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
