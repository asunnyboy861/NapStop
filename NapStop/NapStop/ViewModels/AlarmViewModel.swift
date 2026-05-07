import Foundation
import Observation
import CoreLocation
import SwiftData
import MapKit

@Observable
final class AlarmViewModel {
    private let locationManager = LocationManager()
    private let alarmPlayer = AlarmPlayer.shared
    private let liveActivityManager = LiveActivityManager()
    private let notificationManager = NotificationManager.shared
    private let hapticManager = HapticManager.shared
    private let subwayFallback = SubwayFallbackManager()

    var alarmState: AlarmState = .idle
    var currentDistance: CLLocationDistance?
    var destinationName: String = ""
    var approachRadius: Double = 2000
    var arrivalRadius: Double = 500
    var isApproaching: Bool = false
    var errorMessage: String?

    var distanceDisplay: String {
        guard let distance = currentDistance else { return "--" }
        if distance >= 1000 {
            return String(format: "%.1f km", distance / 1000)
        } else {
            return String(format: "%.0f m", distance)
        }
    }

    var statusText: String {
        switch alarmState {
        case .idle: return "Set your destination"
        case .monitoring: return "Monitoring..."
        case .approaching: return "Getting close!"
        case .ringing: return "Wake up!"
        case .overshoot: return "You may have passed!"
        }
    }

    func requestLocationPermission() {
        locationManager.requestPermission()
    }

    var locationAuthorizationStatus: CLAuthorizationStatus {
        locationManager.authorizationStatus
    }

    func startAlarm(destination: AlarmDestination) {
        let status = locationManager.authorizationStatus

        if status == .notDetermined {
            locationManager.requestPermission()
        }

        guard status == .authorizedAlways || status == .authorizedWhenInUse else {
            errorMessage = "Location access is required to monitor your destination. Please enable location access in Settings."
            return
        }

        destinationName = destination.name
        approachRadius = destination.approachRadius
        arrivalRadius = destination.arrivalRadius

        locationManager.onApproach = { [weak self] in
            self?.handleApproach()
        }
        locationManager.onArrival = { [weak self] in
            self?.handleArrival()
        }
        locationManager.onOvershoot = { [weak self] in
            self?.handleOvershoot()
        }
        locationManager.onLocationUpdate = { [weak self] _ in
            self?.updateDistance()
        }

        locationManager.startMonitoring(
            destination: destination.coordinate,
            arrivalRadius: arrivalRadius,
            approachRadius: approachRadius
        )

        alarmState = .monitoring
        liveActivityManager.startActivity(destinationName: destinationName, distance: distanceDisplay)

        Task {
            await notificationManager.requestAuthorization()
        }
    }

    func stopAlarm() {
        locationManager.stopMonitoring()
        alarmPlayer.stopAlarm()
        subwayFallback.stopFallback()
        liveActivityManager.endActivity()
        notificationManager.removeAllNotifications()
        alarmState = .idle
        currentDistance = nil
        isApproaching = false
    }

    func dismissAlarm() {
        stopAlarm()
    }

    private func handleApproach() {
        alarmState = .approaching
        isApproaching = true
        hapticManager.playApproachHaptic()
        notificationManager.scheduleApproachNotification(destinationName: destinationName)
        liveActivityManager.updateActivity(distance: distanceDisplay, status: "Approaching")
    }

    private func handleArrival() {
        alarmState = .ringing
        alarmPlayer.playAlarm()
        hapticManager.playArrivalHaptic()
        notificationManager.scheduleArrivalNotification(destinationName: destinationName)
        liveActivityManager.updateActivity(distance: distanceDisplay, status: "Arrived!")
    }

    private func handleOvershoot() {
        alarmState = .overshoot
        alarmPlayer.playAlarm()
        hapticManager.playOvershootHaptic()
        notificationManager.scheduleOvershootNotification(destinationName: destinationName)
        liveActivityManager.updateActivity(distance: distanceDisplay, status: "Overshoot!")
    }

    private func updateDistance() {
        currentDistance = locationManager.distanceToDestination
        if alarmState == .monitoring || alarmState == .approaching {
            liveActivityManager.updateActivity(distance: distanceDisplay, status: statusText)
        }
    }
}

enum AlarmState {
    case idle
    case monitoring
    case approaching
    case ringing
    case overshoot
}
