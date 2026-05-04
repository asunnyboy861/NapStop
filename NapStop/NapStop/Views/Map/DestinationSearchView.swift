import SwiftUI
import MapKit

struct DestinationSearchView: View {
    @Bindable var searchVM: MapSearchViewModel
    let onSelect: (MKMapItem) -> Void
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                searchBar

                if searchVM.isSearching {
                    ProgressView()
                        .padding()
                } else if searchVM.searchResults.isEmpty && !searchVM.searchText.isEmpty {
                    emptyState
                } else {
                    resultsList
                }

                Spacer()
            }
            .navigationTitle("Search Destination")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        searchVM.clearSearch()
                        dismiss()
                    }
                }
            }
        }
    }

    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)

            TextField("Search for a place", text: $searchVM.searchText)
                .textFieldStyle(.plain)
                .onSubmit {
                    searchVM.search()
                }

            if !searchVM.searchText.isEmpty {
                Button {
                    searchVM.clearSearch()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding(12)
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .padding(.horizontal)
        .padding(.vertical, 8)
    }

    private var emptyState: some View {
        VStack(spacing: 12) {
            Image(systemName: "mappin.slash")
                .font(.largeTitle)
                .foregroundStyle(.secondary)
            Text("No results found")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding(.top, 40)
    }

    private var resultsList: some View {
        List(searchVM.searchResults, id: \.self) { item in
            Button {
                onSelect(item)
            } label: {
                HStack {
                    Image(systemName: "mappin.circle.fill")
                        .foregroundStyle(Color("AccentOrange"))
                        .font(.title3)

                    VStack(alignment: .leading, spacing: 2) {
                        Text(item.name ?? "Unknown")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundStyle(.primary)

                        Text(formatAddress(item))
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .lineLimit(1)
                    }

                    Spacer()

                    Image(systemName: "chevron.right")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
                .padding(.vertical, 4)
            }
            .buttonStyle(.plain)
        }
        .listStyle(.plain)
    }

    private func formatAddress(_ item: MKMapItem) -> String {
        let placemark = item.placemark
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

#Preview {
    DestinationSearchView(searchVM: MapSearchViewModel()) { _ in }
}
