//
//  LocationView.swift
//  Weather-App
//
//  Created by rentamac on 1/23/26.

//#Preview {
//    LocationView(location: Location(
//        name: "Mumbai",
//        weather: .sunny,
//        temperature: Temperature(min: 22, max: 32)
//    )
//    )
//}
import SwiftUI

struct LocationView: View {

    @ObservedObject var weather: WeatherCache

    @StateObject private var viewModel = LocationViewModel(
        weatherService: WeatherService(
            networkService: HttpNetworking()
        )
    )

    @Environment(\.dismiss) private var dismiss

    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ZStack {
            Color("bgColor")
                .ignoresSafeArea()

            VStack(spacing: 24) {

                // City name
                Text(weather.name ?? "")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.top, 40)

                // Weather icon (placeholder for now)
                Image(systemName: "cloud.sun.fill")
                    .font(.system(size: 120))
                    .foregroundColor(.yellow)

                // Main temperature
                Group {
                    if viewModel.isLoading {
                        ProgressView()
                            .tint(.white)
                    } else if weather.isSynced {
                        Text("\(Int(weather.temperature))°C")
                            .font(.system(size: 48, weight: .bold))
                            .foregroundColor(.white)
                    } else if let error = viewModel.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                    }
                }

                // Extra Weather Features
                if weather.isSynced {
                    LazyVGrid(columns: columns, spacing: 12) {

                        WeatherInfoCard(
                            title: "Feels Like",
                            value: "\(Int(weather.feelsLike))°C"
                        )

                        WeatherInfoCard(
                            title: "Humidity",
                            value: "\(weather.humidity)%"
                        )

                        WeatherInfoCard(
                            title: "Wind Speed",
                            value: "\(weather.windSpeed) km/h"
                        )

                        WeatherInfoCard(
                            title: "Direction",
                            value: "\(weather.windDirection)°"
                        )
                    }
                    .padding(.horizontal)
                }

                Spacer()
            }
        }
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
        .task {
            await viewModel.loadWeatherIfNeeded(for: weather)
        }
    }
}
