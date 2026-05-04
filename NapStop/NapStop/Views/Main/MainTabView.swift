import SwiftUI
import SwiftData

struct MainTabView: View {
    var body: some View {
        TabView {
            SetAlarmView()
                .tabItem {
                    Label("Alarm", systemImage: "alarm")
                }

            AlarmHistoryView()
                .tabItem {
                    Label("History", systemImage: "clock.arrow.circlepath")
                }

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
        .tint(Color("AccentOrange"))
    }
}

#Preview {
    MainTabView()
        .modelContainer(for: [AlarmDestination.self, AlarmRecord.self])
}
