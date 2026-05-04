import Foundation
import SwiftData
import CoreLocation

@Model
final class AlarmDestination {
    var id: UUID
    var name: String
    var latitude: Double
    var longitude: Double
    var address: String
    var arrivalRadius: Double
    var approachRadius: Double
    var isFavorite: Bool
    var createdAt: Date

    init(
        name: String,
        latitude: Double,
        longitude: Double,
        address: String = "",
        arrivalRadius: Double = 500,
        approachRadius: Double = 2000,
        isFavorite: Bool = false
    ) {
        self.id = UUID()
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.address = address
        self.arrivalRadius = arrivalRadius
        self.approachRadius = approachRadius
        self.isFavorite = isFavorite
        self.createdAt = Date()
    }

    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
