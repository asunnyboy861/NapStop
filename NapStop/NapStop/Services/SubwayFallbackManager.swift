import CoreMotion
import CoreLocation

@Observable
final class SubwayFallbackManager {
    private let motionManager = CMMotionManager()
    private var lastKnownLocation: CLLocation?
    private var lastKnownSpeed: Double = 0
    private var lastUpdateTime: Date = Date()
    private var estimatedLocation: CLLocation?
    private var isRunning = false

    var onEstimatedUpdate: ((CLLocation) -> Void)?

    func startFallback(lastLocation: CLLocation, lastSpeed: Double) {
        self.lastKnownLocation = lastLocation
        self.lastKnownSpeed = lastSpeed
        self.estimatedLocation = lastLocation
        self.isRunning = true

        guard motionManager.isDeviceMotionAvailable else { return }
        motionManager.deviceMotionUpdateInterval = 1.0
        motionManager.startDeviceMotionUpdates(to: .main) { [weak self] motion, error in
            guard let self = self, error == nil else { return }
            let timeElapsed = Date().timeIntervalSince(self.lastUpdateTime)
            let estimatedDistance = self.lastKnownSpeed * timeElapsed
            if let last = self.estimatedLocation, let known = self.lastKnownLocation {
                let bearing = self.lastKnownSpeed > 0 ? self.calculateBearing(from: known, to: last) : 0
                self.estimatedLocation = self.offsetLocation(from: last, distance: estimatedDistance, bearing: bearing)
                self.onEstimatedUpdate?(self.estimatedLocation!)
            }
            self.lastUpdateTime = Date()
        }
    }

    func stopFallback() {
        motionManager.stopDeviceMotionUpdates()
        isRunning = false
    }

    private func calculateBearing(from: CLLocation, to: CLLocation) -> Double {
        let lat1 = from.coordinate.latitude * .pi / 180
        let lat2 = to.coordinate.latitude * .pi / 180
        let diffLon = (to.coordinate.longitude - from.coordinate.longitude) * .pi / 180
        let y = sin(diffLon) * cos(lat2)
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(diffLon)
        return atan2(y, x)
    }

    private func offsetLocation(from: CLLocation, distance: Double, bearing: Double) -> CLLocation {
        let earthRadius = 6371000.0
        let lat1 = from.coordinate.latitude * .pi / 180
        let lon1 = from.coordinate.longitude * .pi / 180
        let lat2 = asin(sin(lat1) * cos(distance / earthRadius) + cos(lat1) * sin(distance / earthRadius) * cos(bearing))
        let lon2 = lon1 + atan2(sin(bearing) * sin(distance / earthRadius) * cos(lat1), cos(distance / earthRadius) - sin(lat1) * sin(lat2))
        return CLLocation(latitude: lat2 * 180 / .pi, longitude: lon2 * 180 / .pi)
    }
}
