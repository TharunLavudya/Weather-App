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

    @Published var currentWeather: Current?
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

            currentWeather = response.current
            
            isLoading = false

        } catch {
            errorMessage = "Failed to load weather data"
            isLoading = false
        }

        
    }
}
