import UserNotifications

final class NotificationManager {
    static let shared = NotificationManager()

    private init() {}

    func requestAuthorization() async -> Bool {
        do {
            return try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .criticalAlert])
        } catch {
            print("Notification auth error: \(error)")
            return false
        }
    }

    func scheduleApproachNotification(destinationName: String) {
        let content = UNMutableNotificationContent()
        content.title = "Approaching \(destinationName)"
        content.body = "You are getting close to your stop. Get ready!"
        content.sound = .defaultCritical
        content.categoryIdentifier = "APPROACH"

        let request = UNNotificationRequest(
            identifier: "approach-\(destinationName)",
            content: content,
            trigger: nil
        )

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Notification error: \(error)")
            }
        }
    }

    func scheduleArrivalNotification(destinationName: String) {
        let content = UNMutableNotificationContent()
        content.title = "You have arrived at \(destinationName)!"
        content.body = "This is your stop. Wake up!"
        content.sound = .defaultCritical
        content.categoryIdentifier = "ARRIVAL"

        let request = UNNotificationRequest(
            identifier: "arrival-\(destinationName)",
            content: content,
            trigger: nil
        )

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Notification error: \(error)")
            }
        }
    }

    func scheduleOvershootNotification(destinationName: String) {
        let content = UNMutableNotificationContent()
        content.title = "You may have passed \(destinationName)!"
        content.body = "It looks like you went past your stop. Check your location!"
        content.sound = .defaultCritical
        content.categoryIdentifier = "OVERSHOOT"

        let request = UNNotificationRequest(
            identifier: "overshoot-\(destinationName)",
            content: content,
            trigger: nil
        )

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Notification error: \(error)")
            }
        }
    }

    func removeAllNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
}
