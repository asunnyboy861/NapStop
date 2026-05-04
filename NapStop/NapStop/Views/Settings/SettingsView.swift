import SwiftUI

struct SettingsView: View {
    @AppStorage("approachRadius") private var approachRadius: Double = 2000
    @AppStorage("arrivalRadius") private var arrivalRadius: Double = 500
    @AppStorage("alarmSoundEnabled") private var alarmSoundEnabled: Bool = true
    @AppStorage("vibrationEnabled") private var vibrationEnabled: Bool = true
    @AppStorage("liveActivityEnabled") private var liveActivityEnabled: Bool = true

    var body: some View {
        NavigationStack {
            Form {
                alarmSection
                radiusSection
                featuresSection
                aboutSection
            }
            .navigationTitle("Settings")
            .frame(maxWidth: 720)
            .frame(maxWidth: .infinity)
        }
    }

    private var alarmSection: some View {
        Section("Alarm") {
            Toggle("Sound Alarm", isOn: $alarmSoundEnabled)
            Toggle("Vibration", isOn: $vibrationEnabled)
        }
    }

    private var radiusSection: some View {
        Section("Alarm Radius") {
            VStack(alignment: .leading) {
                Text("Approach Alert: \(formatDistance(approachRadius))")
                Slider(value: $approachRadius, in: 500...5000, step: 100)
                Text("Alerts you when you're this far from your stop")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            VStack(alignment: .leading) {
                Text("Arrival Alert: \(formatDistance(arrivalRadius))")
                Slider(value: $arrivalRadius, in: 100...2000, step: 50)
                Text("Rings the alarm when you're this close")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }

    private var featuresSection: some View {
        Section("Features") {
            Toggle("Live Activity", isOn: $liveActivityEnabled)
            Text("Show distance on lock screen and Dynamic Island")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }

    private var aboutSection: some View {
        Section("About") {
            NavigationLink {
                ContactSupportView()
            } label: {
                Label("Contact Support", systemImage: "envelope")
            }

            Link(destination: URL(string: "https://asunnyboy861.github.io/NapStop/privacy.html")!) {
                Label("Privacy Policy", systemImage: "hand.raised")
            }

            Link(destination: URL(string: "https://asunnyboy861.github.io/NapStop/support.html")!) {
                Label("Support", systemImage: "questionmark.circle")
            }

            HStack {
                Text("Version")
                Spacer()
                Text(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0")
                    .foregroundStyle(.secondary)
            }
        }
    }

    private func formatDistance(_ meters: Double) -> String {
        if meters >= 1000 {
            return String(format: "%.1f km", meters / 1000)
        } else {
            return String(format: "%.0f m", meters)
        }
    }
}

#Preview {
    SettingsView()
}
