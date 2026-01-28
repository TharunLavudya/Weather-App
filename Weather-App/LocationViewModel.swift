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

    @Published var isLoading = false
    @Published var errorMessage: String?

    private let weatherService: WeatherServiceProtocol
    private let db = PersistenceController.shared

    init(weatherService: WeatherServiceProtocol) {
        self.weatherService = weatherService
    }

    // Fetches weather ONLY if not present or expired (1 minute)
    func loadWeatherIfNeeded(for weather: WeatherCache) async {

        //  Cache check (1 minute)
        if let updatedAt = weather.updatedAt,
           Date().timeIntervalSince(updatedAt) < 60 {
            return
        }

        isLoading = true
        errorMessage = nil

        do {
            let response = try await weatherService.fetchWeather(
                latitude: weather.latitude,
                longitude: weather.longitude
            )

            let current = response.current

            // Update Core Data
            db.updateWeatherDetails(
                for: weather,
                temperature: current.temperature2M,
                feelsLike: current.apparentTemperature,
                humidity: current.relativeHumidity2M,
                windSpeed: current.windSpeed10M,
                windDirection: current.windDirection10M
            )

        } catch {
            errorMessage = "Failed to load weather data"
        }

        isLoading = false
    }
}
