import SwiftUI
import SwiftData

struct AlarmHistoryView: View {
    @Query(sort: \AlarmRecord.startedAt, order: .reverse) private var records: [AlarmRecord]
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        NavigationStack {
            Group {
                if records.isEmpty {
                    emptyState
                } else {
                    recordsList
                }
            }
            .navigationTitle("History")
            .frame(maxWidth: 720)
            .frame(maxWidth: .infinity)
        }
    }

    private var emptyState: some View {
        ContentUnavailableView(
            "No Alarms Yet",
            systemImage: "clock.arrow.circlepath",
            description: Text("Your alarm history will appear here after you set your first alarm.")
        )
    }

    private var recordsList: some View {
        List {
            ForEach(records) { record in
                HStack {
                    Image(systemName: statusIcon(for: record.status))
                        .foregroundStyle(statusColor(for: record.status))
                        .font(.title3)

                    VStack(alignment: .leading, spacing: 4) {
                        Text(record.destinationName)
                            .font(.subheadline)
                            .fontWeight(.medium)

                        Text(record.startedAt, style: .date)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }

                    Spacer()

                    if record.status == "active" {
                        Text("Active")
                            .font(.caption2)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.green.opacity(0.15))
                            .foregroundStyle(.green)
                            .clipShape(Capsule())
                    }
                }
                .padding(.vertical, 4)
            }
            .onDelete(perform: deleteRecords)
        }
        .listStyle(.plain)
    }

    private func statusIcon(for status: String) -> String {
        switch status {
        case "active": return "alarm.fill"
        case "arrived": return "checkmark.circle.fill"
        case "cancelled": return "xmark.circle.fill"
        case "overshoot": return "exclamationmark.triangle.fill"
        default: return "clock.fill"
        }
    }

    private func statusColor(for status: String) -> Color {
        switch status {
        case "active": return .green
        case "arrived": return Color("AccentOrange")
        case "cancelled": return .secondary
        case "overshoot": return .red
        default: return .secondary
        }
    }

    private func deleteRecords(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(records[index])
        }
    }
}

#Preview {
    AlarmHistoryView()
        .modelContainer(for: AlarmRecord.self)
}
