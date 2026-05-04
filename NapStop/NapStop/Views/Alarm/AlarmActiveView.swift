import SwiftUI
import MapKit

struct AlarmActiveView: View {
    let alarmVM: AlarmViewModel

    var body: some View {
        VStack(spacing: 24) {
            statusHeader

            distanceDisplay

            mapPreview

            controlsSection

            Spacer()
        }
        .padding()
        .frame(maxWidth: 720)
        .frame(maxWidth: .infinity)
    }

    private var statusHeader: some View {
        VStack(spacing: 8) {
            Circle()
                .fill(statusColor)
                .frame(width: 16, height: 16)
                .overlay(
                    Circle()
                        .fill(statusColor.opacity(0.3))
                        .frame(width: 32, height: 32)
                        .animation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true), value: alarmVM.alarmState)
                )

            Text(alarmVM.statusText)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundStyle(statusColor)

            Text("To: \(alarmVM.destinationName)")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding(.top, 20)
    }

    private var distanceDisplay: some View {
        VStack(spacing: 4) {
            Text(alarmVM.distanceDisplay)
                .font(.system(size: 56, weight: .bold, design: .rounded))
                .foregroundStyle(statusColor)
                .contentTransition(.numericText())

            Text("from destination")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }

    private var mapPreview: some View {
        Map()
            .frame(height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(statusColor.opacity(0.3), lineWidth: 2)
            )
    }

    private var controlsSection: some View {
        VStack(spacing: 12) {
            Button(role: .destructive) {
                alarmVM.stopAlarm()
            } label: {
                Label("Cancel Alarm", systemImage: "xmark.circle.fill")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red.opacity(0.1))
                    .foregroundStyle(.red)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
    }

    private var statusColor: Color {
        switch alarmVM.alarmState {
        case .idle: return .gray
        case .monitoring: return Color("DeepBlue")
        case .approaching: return .yellow
        case .ringing: return .green
        case .overshoot: return .red
        }
    }
}

#Preview {
    AlarmActiveView(alarmVM: {
        let vm = AlarmViewModel()
        return vm
    }())
}
