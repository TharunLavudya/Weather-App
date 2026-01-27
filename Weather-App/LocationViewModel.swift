//
//  LocationViewModel.swift
//  Weather-App
//
//  Created by rentamac on 1/26/26.
//

import Foundation
import Combine

@MainActor
final class LocationViewModel: ObservableObject {

    @Published var weatherDetails: WeatherDetails?
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let weatherService: WeatherServiceProtocol

    init(weatherService: WeatherServiceProtocol) {
        self.weatherService = weatherService
    }

    func fetchWeather(for location: Location) async {
        isLoading = true
        errorMessage = nil

        do {
            let response = try await weatherService.fetchWeather(
                latitude: location.latitude,
                longitude: location.longitude
            )

            let current = response.current

            weatherDetails = WeatherDetails(
                temperature: current.temperature2M,
                feelsLike: current.apparentTemperature,
                humidity: current.relativeHumidity2M,
                windSpeed: current.windSpeed10M,
                windDirection: current.windDirection10M,
                weatherCode: current.weatherCode,
                Precepitation: current.precipitation
            )
            isLoading = false

        } catch {
            errorMessage = "Failed to load weather data"
            isLoading = false
        }

        
    }
}
