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

    let location: Location

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
            LinearGradient(
                colors: [.black, .blue.opacity(0.7)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 24) {

                Text(location.name)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.top, 40)

                Image(systemName: location.weather.icon)
                    .font(.system(size: 120))
                    .foregroundColor(.yellow)

                // Main Temperature
                Group {
                    if viewModel.isLoading {
                        ProgressView()
                            .tint(.white)
                    } else if let current = viewModel.currentWeather {
                        Text("\(Int(current.temperature2M))°C")
                            .font(.system(size: 48, weight: .bold))
                            .foregroundColor(.white)
                    } else if let error = viewModel.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                    }
                }

                // Extra Weather Features (Grid)
                if let current = viewModel.currentWeather {
                    LazyVGrid(columns: columns, spacing: 12) {

                        WeatherInfoCard(
                            title: "Feels Like",
                            value: "\(Int(current.apparentTemperature))°C"
                        )

                        WeatherInfoCard(
                            title: "Humidity",
                            value: "\(current.relativeHumidity2M)%"
                        )

                        WeatherInfoCard(
                            title: "Wind Speed",
                            value: "\(current.windSpeed10M) km/h"
                        )

                        WeatherInfoCard(
                            title: "Direction",
                            value: "\(current.windDirection10M)°"
                        )

                        WeatherInfoCard(
                            title: "Weather Code",
                            value: "\(current.weatherCode)"
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
            await viewModel.fetchWeather(for: location)
        }
    }
}
