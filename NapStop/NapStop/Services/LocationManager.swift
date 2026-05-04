import CoreLocation
import Observation

@Observable
final class LocationManager: NSObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    private var geofenceRegion: CLCircularRegion?
    private var approachRegion: CLCircularRegion?

    var currentLocation: CLLocation?
    var distanceToDestination: CLLocationDistance?
    var isMonitoring = false
    var authorizationStatus: CLAuthorizationStatus = .notDetermined
    var onApproach: (() -> Void)?
    var onArrival: (() -> Void)?
    var onOvershoot: (() -> Void)?
    var onLocationUpdate: ((CLLocation) -> Void)?

    private var destination: CLLocationCoordinate2D?
    private var previousDistance: CLLocationDistance?
    private var consecutiveIncreases = 0

    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        manager.distanceFilter = 50
        manager.allowsBackgroundLocationUpdates = true
        manager.showsBackgroundLocationIndicator = true
        manager.pausesLocationUpdatesAutomatically = false
    }

    func requestPermission() {
        manager.requestAlwaysAuthorization()
    }

    func startMonitoring(destination: CLLocationCoordinate2D, arrivalRadius: Double, approachRadius: Double) {
        self.destination = destination
        self.previousDistance = nil
        self.consecutiveIncreases = 0

        let arrivalRegion = CLCircularRegion(
            center: destination,
            radius: arrivalRadius,
            identifier: "arrival"
        )
        arrivalRegion.notifyOnEntry = true
        arrivalRegion.notifyOnExit = false

        let approachRegion = CLCircularRegion(
            center: destination,
            radius: approachRadius,
            identifier: "approach"
        )
        approachRegion.notifyOnEntry = true
        approachRegion.notifyOnExit = false

        self.geofenceRegion = arrivalRegion
        self.approachRegion = approachRegion

        manager.startMonitoring(for: approachRegion)
        manager.startMonitoring(for: arrivalRegion)
        manager.startUpdatingLocation()

        isMonitoring = true
    }

    func stopMonitoring() {
        if let approach = approachRegion {
            manager.stopMonitoring(for: approach)
        }
        if let geofence = geofenceRegion {
            manager.stopMonitoring(for: geofence)
        }
        manager.stopUpdatingLocation()
        isMonitoring = false
        destination = nil
        previousDistance = nil
        consecutiveIncreases = 0
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        currentLocation = location

        if let dest = destination {
            let destLocation = CLLocation(latitude: dest.latitude, longitude: dest.longitude)
            let distance = location.distance(from: destLocation)
            distanceToDestination = distance
            checkOvershoot(currentDistance: distance)
        }

        onLocationUpdate?(location)
    }

    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        switch region.identifier {
        case "approach":
            onApproach?()
        case "arrival":
            onArrival?()
        default:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        authorizationStatus = status
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error.localizedDescription)")
    }

    private func checkOvershoot(currentDistance: CLLocationDistance) {
        guard let prev = previousDistance else {
            previousDistance = currentDistance
            return
        }

        if currentDistance > prev {
            consecutiveIncreases += 1
        } else {
            consecutiveIncreases = 0
        }

        if consecutiveIncreases >= 3 && prev < 2000 {
            onOvershoot?()
        }
        previousDistance = currentDistance
    }
}
