import Foundation
import Observation
import MapKit

@Observable
final class MapSearchViewModel {
    var searchResults: [MKMapItem] = []
    var searchText: String = ""
    var isSearching: Bool = false
    var selectedPlace: MKMapItem?

    func search() {
        guard !searchText.isEmpty else {
            searchResults = []
            return
        }

        isSearching = true
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        request.resultTypes = .pointOfInterest

        let search = MKLocalSearch(request: request)
        search.start { [weak self] response, error in
            DispatchQueue.main.async {
                self?.isSearching = false
                if let response = response {
                    self?.searchResults = Array(response.mapItems.prefix(10))
                } else {
                    self?.searchResults = []
                }
            }
        }
    }

    func selectPlace(_ item: MKMapItem) {
        selectedPlace = item
    }

    func clearSearch() {
        searchText = ""
        searchResults = []
        selectedPlace = nil
    }
}
