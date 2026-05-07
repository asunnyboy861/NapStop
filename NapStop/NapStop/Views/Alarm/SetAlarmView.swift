import SwiftUI
import SwiftData
import MapKit
import CoreLocation

struct SetAlarmView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var alarmVM = AlarmViewModel()
    @State private var searchVM = MapSearchViewModel()
    @Binding var showSearch: Bool
    @State private var showActiveAlarm = false
    @State private var selectedDestination: AlarmDestination?
    @State private var showLocationDeniedAlert = false
    @Query(filter: #Predicate<AlarmDestination> { $0.isFavorite },
           sort: \AlarmDestination.createdAt) private var favorites: [AlarmDestination]

    var body: some View {
        NavigationStack {
            Group {
                if alarmVM.alarmState == .idle {
                    idleView
                } else {
                    AlarmActiveView(alarmVM: alarmVM)
                }
            }
            .navigationTitle("NapStop")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                if alarmVM.alarmState == .idle {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            showSearch = true
                        } label: {
                            Image(systemName: "magnifyingglass")
                        }
                    }
                }
            }
            .sheet(isPresented: $showSearch) {
                DestinationSearchView(searchVM: searchVM) { mapItem in
                    let destination = AlarmDestination(
                        name: mapItem.name ?? "Unknown",
                        latitude: mapItem.placemark.coordinate.latitude,
                        longitude: mapItem.placemark.coordinate.longitude,
                        address: formatAddress(mapItem)
                    )
                    selectedDestination = destination
                    startAlarm(destination: destination)
                    showSearch = false
                }
            }
            .fullScreenCover(isPresented: $showActiveAlarm) {
                AlarmRingingView(alarmVM: alarmVM)
            }
            .onChange(of: alarmVM.alarmState) { _, newState in
                if newState == .ringing || newState == .overshoot {
                    showActiveAlarm = true
                }
            }
            .alert("Location Access Required", isPresented: $showLocationDeniedAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Open Settings") {
                    if let url = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(url)
                    }
                }
            } message: {
                Text("NapStop needs location access to monitor your destination and alert you when you arrive. Please enable location access in Settings.")
            }
        }
    }

    private var idleView: some View {
        ScrollView {
            VStack(spacing: 24) {
                heroSection

                if !favorites.isEmpty {
                    favoritesSection
                }

                quickSetupSection

                Spacer(minLength: 100)
            }
            .padding()
        }
        .frame(maxWidth: 720)
        .frame(maxWidth: .infinity)
    }

    private var heroSection: some View {
        VStack(spacing: 16) {
            Image(systemName: "location.circle.fill")
                .font(.system(size: 64))
                .foregroundStyle(Color("AccentOrange"))

            Text("Never Miss Your Stop")
                .font(.title2)
                .fontWeight(.semibold)

            Text("Set a location alarm and take a nap. We'll wake you up before your stop.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding(.vertical, 20)
    }

    private var favoritesSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Favorites")
                .font(.headline)
                .foregroundStyle(.secondary)

            ForEach(favorites) { destination in
                Button {
                    startAlarm(destination: destination)
                } label: {
                    FavoriteRow(destination: destination)
                }
                .buttonStyle(.plain)
            }
        }
    }

    private var quickSetupSection: some View {
        VStack(spacing: 16) {
            Button {
                showSearch = true
            } label: {
                Label("Search Destination", systemImage: "magnifyingglass")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("AccentOrange"))
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
    }

    private func startAlarm(destination: AlarmDestination) {
        let status = alarmVM.locationAuthorizationStatus

        if status == .denied || status == .restricted {
            showLocationDeniedAlert = true
            return
        }

        let record = AlarmRecord(
            destinationName: destination.name,
            destinationLatitude: destination.latitude,
            destinationLongitude: destination.longitude,
            approachRadius: destination.approachRadius,
            arrivalRadius: destination.arrivalRadius
        )
        modelContext.insert(record)
        alarmVM.startAlarm(destination: destination)

        if alarmVM.errorMessage != nil {
            showLocationDeniedAlert = true
            alarmVM.errorMessage = nil
        }
    }

    private func formatAddress(_ mapItem: MKMapItem) -> String {
        let placemark = mapItem.placemark
        var components: [String] = []
        if let thoroughfare = placemark.thoroughfare {
            components.append(thoroughfare)
        }
        if let locality = placemark.locality {
            components.append(locality)
        }
        return components.joined(separator: ", ")
    }
}

struct FavoriteRow: View {
    let destination: AlarmDestination

    var body: some View {
        HStack {
            Image(systemName: "star.fill")
                .foregroundStyle(.yellow)

            VStack(alignment: .leading) {
                Text(destination.name)
                    .font(.subheadline)
                    .fontWeight(.medium)
                Text(destination.address)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: .black.opacity(0.05), radius: 2, y: 1)
    }
}

#Preview {
    SetAlarmView(showSearch: .constant(false))
        .modelContainer(for: [AlarmDestination.self, AlarmRecord.self])
}
