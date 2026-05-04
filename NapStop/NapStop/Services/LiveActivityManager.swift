import ActivityKit
import Observation

@Observable
final class LiveActivityManager {
    private var activity: Activity<NapStopAttributes>?

    func startActivity(destinationName: String, distance: String) {
        guard ActivityAuthorizationInfo().areActivitiesEnabled else { return }

        let attributes = NapStopAttributes(destinationName: destinationName)
        let state = NapStopAttributes.ContentState(
            distance: distance,
            status: "On the way",
            destinationName: destinationName
        )

        do {
            activity = try Activity.request(
                attributes: attributes,
                content: .init(state: state, staleDate: nil)
            )
        } catch {
            print("Live Activity error: \(error)")
        }
    }

    func updateActivity(distance: String, status: String) {
        let state = NapStopAttributes.ContentState(
            distance: distance,
            status: status,
            destinationName: activity?.attributes.destinationName ?? ""
        )
        Task {
            await activity?.update(.init(state: state, staleDate: nil))
        }
    }

    func endActivity() {
        Task {
            await activity?.end(nil, dismissalPolicy: .immediate)
            activity = nil
        }
    }
}

struct NapStopAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        var distance: String
        var status: String
        var destinationName: String
    }
    var destinationName: String
}
