import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var selectedTab = 0
    @State private var showSearch = false

    var body: some View {
        MainTabView(selectedTab: $selectedTab, showSearch: $showSearch)
    }
}

#Preview {
    ContentView()
        .modelContainer(for: [AlarmDestination.self, AlarmRecord.self])
}
