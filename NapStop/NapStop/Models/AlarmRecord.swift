import Foundation
import SwiftData

@Model
final class AlarmRecord {
    var id: UUID
    var destinationName: String
    var destinationLatitude: Double
    var destinationLongitude: Double
    var startedAt: Date
    var endedAt: Date?
    var status: String
    var approachRadius: Double
    var arrivalRadius: Double

    init(
        destinationName: String,
        destinationLatitude: Double,
        destinationLongitude: Double,
        approachRadius: Double = 2000,
        arrivalRadius: Double = 500
    ) {
        self.id = UUID()
        self.destinationName = destinationName
        self.destinationLatitude = destinationLatitude
        self.destinationLongitude = destinationLongitude
        self.startedAt = Date()
        self.endedAt = nil
        self.status = "active"
        self.approachRadius = approachRadius
        self.arrivalRadius = arrivalRadius
    }
}
