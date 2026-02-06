//
//  WeatherModel.swift
//  Weather-App
//
//  Created by rentamac on 1/22/26.
//
import Foundation

enum Weather: Hashable{
    case sunny
    case foggy
    case snow
    case rainy
    case windy
    
    var icon: String {
        switch self {
        case .sunny:
            return "sun.max.fill"
        case .foggy:
            return "cloud.fog.fill"
        case .snow:
            return "snowflake"
        case .rainy:
            return "cloud.rain.fill"
        case .windy:
            return "wind"
        }
    }
}

struct Temperature: Hashable {
    let min: Int
    let max: Int
    
    var temperatureText: String {
        "\(min) °C / \(max) °C"
    }
}

struct Location: Identifiable, Hashable{
    let id: UUID = UUID()
    let name: String
    let weather: Weather
    let temperature: Temperature
    let latitude: Double
    let longitude: Double
}
