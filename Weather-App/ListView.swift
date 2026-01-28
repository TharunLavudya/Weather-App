//
//  ListView.swift
//  Weather-App
//
//  Created by rentamac on 1/22/26.
//

import SwiftUI

struct ListView: View {

    @StateObject private var viewModel = ViewModel()
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {

                List {
                    ForEach(viewModel.locations, id: \.objectID) { location in
                        NavigationLink {
                            LocationView(weather: location)
                        } label: {
                            LocationRow(location: location)
                        }
                        .listRowBackground(Color.clear)
                    }
             
                    // DELETE BUTTON
                    if !viewModel.locations.isEmpty {
                        Section {
                            Button {
                                viewModel.resetWeatherData()
                            } label: {
                                HStack {
                                    Spacer()
                                    Text("Clear Weather Data")
                                        .foregroundColor(.red.opacity(0.85))
                                        .fontWeight(.semibold)
                                    Spacer()
                                }
                                .padding(.vertical, 12)
                            }
                            .listRowBackground(Color.clear)
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .background(Color("bgColor"))
            }
            .navigationTitle("Locations")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                    }
                }
            }
            .searchable(
                text: $viewModel.searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Search"
            )
        }
    }
}

struct LocationRow: View {
    @ObservedObject var location: WeatherCache

    var body: some View {
        HStack {
            Image(systemName: weatherIcon(for: location))
                .foregroundColor(.yellow)

            Text(location.name ?? "")
                .foregroundColor(.white)

            Spacer()

            if location.isSynced {
                Text("\(Int(location.temperature))°")
                    .foregroundColor(.white)
            } else {
                Text("--")
                    .foregroundColor(.gray)
            }
        }
    }
}

private func weatherIcon(for location: WeatherCache) -> String {
    if location.isSynced {
        return "cloud.sun.fill"
    } else {
        return "clock"
    }
}

//#Preview {
//    ListView()
//}
