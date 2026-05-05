import SwiftUI
import SwiftData

struct MainTabView: View {
    @Binding var selectedTab: Int
    @Binding var showSearch: Bool

    var body: some View {
        TabView(selection: $selectedTab) {
            SetAlarmView(showSearch: $showSearch)
                .tabItem {
                    Label("Alarm", systemImage: "alarm")
                }
                .tag(0)

            AlarmHistoryView()
                .tabItem {
                    Label("History", systemImage: "clock.arrow.circlepath")
                }
                .tag(1)

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
                .tag(2)
        }
        .tint(Color("AccentOrange"))
    }
}

#Preview {
    MainTabView(selectedTab: .constant(0), showSearch: .constant(false))
        .modelContainer(for: [AlarmDestination.self, AlarmRecord.self])
}
