//
//  SearchLocationView.swift
//  Weather-App
//
//  Created by rentamac on 1/30/26.
//

import SwiftUI
import MapKit

struct SearchLocationView: View {

    @StateObject private var viewModel = SearchLocationViewModel(
        service: GeoService(
            networking: HttpNetworking()
        )
    )

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            List {
                if viewModel.isLoading {
                    ProgressView("Searching...")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                else if viewModel.results.isEmpty && !viewModel.searchText.isEmpty {
                    Text("No locations found")
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                else {
                    ForEach(viewModel.results) { location in
                        Button {
                            save(location)
                            dismiss()
                        } label: {
                            VStack(alignment: .leading, spacing: 12) {
                                Map(
                                    coordinateRegion: .constant(
                                        MKCoordinateRegion(
                                            center: CLLocationCoordinate2D(
                                                latitude: location.latitude,
                                                longitude: location.longitude
                                            ),
                                            span: MKCoordinateSpan(
                                                latitudeDelta: 0.5,
                                                longitudeDelta: 0.5
                                            )
                                        )
                                    )
                                )
                                .frame(height: 120)
                                .cornerRadius(12)
                                .allowsHitTesting(false)
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(location.name)
                                        .font(.headline)
                                        .foregroundColor(.primary)

                                    if let country = location.country {
                                        Text(country)
                                            .font(.caption)
                                            .foregroundColor(.secondary)
                                    }
                                }
                            }
                            .padding(.vertical, 8)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            .navigationTitle("Add Location")
            .searchable(text: $viewModel.searchText, prompt: "Search city")
            .onSubmit(of: .search) {
                Task {
                    await viewModel.search()
                }
            }
        }
    }

    private func save(_ place: GeoResult) {
        PersistenceController.shared.createWeather(
            id: UUID(),
            name: place.name,
            latitude: place.latitude,
            longitude: place.longitude
        )
    }
}
