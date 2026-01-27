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

    var body: some View {
        ZStack {
            
            Color("bgColor").ignoresSafeArea()

            VStack(spacing: 24) {

                // City Name
                Text(location.name)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(.top, 40)

                // Weather Icon
                Image(systemName: location.weather.icon)
                    .font(.system(size: 120))
                    .foregroundColor(.yellow)

                // Main Temperature
                Group {
                    if viewModel.isLoading {
                        ProgressView()
                            .tint(.white)
                    } else if let details = viewModel.weatherDetails {
                        Text("\(Int(details.temperature))°C")
                            .font(.system(size: 48, weight: .bold))
                            .foregroundColor(.white)
                    } else if let error = viewModel.errorMessage {
                        Text(error)
                            .foregroundColor(.red)
                    }
                }

                // Weather Details (6 Features)
                if let details = viewModel.weatherDetails {

                    let columns = [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ]

                    LazyVGrid(columns: columns, spacing: 12) {

                        WeatherInfoCard(
                            title: "Wind",
                            value: "\(details.windSpeed) km/h"
                        )

                        WeatherInfoCard(
                            title: "Humidity",
                            value: "\(details.humidity)%"
                        )

                        WeatherInfoCard(
                            title: "Feels Like",
                            value: "\(Int(details.feelsLike))°C"
                        )

                        WeatherInfoCard(
                            title: "Direction",
                            value: "\(details.windDirection)°"
                        )
                       WeatherInfoCard(
                            title: "Weather Code",
                            value: "\(details.weatherCode)"
                        )
                        WeatherInfoCard(
                             title: "Precepitation",
                             value: "\(details.Precepitation)"
                         )
                        
                    }
                    .padding()
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
