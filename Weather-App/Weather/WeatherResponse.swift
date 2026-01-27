//
//  WeatherResponse.swift
//  Weather-App
//
//  Created by rentamac on 1/26/26.
//
struct WeatherResponse: Codable {
    let latitude, longitude, generationtimeMS: Double
    let utcOffsetSeconds: Int
    let timezone, timezoneAbbreviation: String
    let elevation: Int
    let currentUnits: CurrentUnits
    let current: Current

    enum CodingKeys: String, CodingKey {
        case latitude, longitude
        case generationtimeMS = "generationtime_ms"
        case utcOffsetSeconds = "utc_offset_seconds"
        case timezone
        case timezoneAbbreviation = "timezone_abbreviation"
        case elevation
        case currentUnits = "current_units"
        case current
    }
}

// MARK: - Current
struct Current: Codable {
    let time: String
    let interval: Int
    let temperature2M: Double
    let relativeHumidity2M: Int
    let apparentTemperature: Double
    let weatherCode: Int
    let windSpeed10M: Double
    let windDirection10M: Int
    let precipitation: Double

    enum CodingKeys: String, CodingKey {
        case time
        case interval
        case temperature2M = "temperature_2m"
        case relativeHumidity2M = "relative_humidity_2m"
        case apparentTemperature = "apparent_temperature"
        case weatherCode = "weather_code"
        case windSpeed10M = "wind_speed_10m"
        case windDirection10M = "wind_direction_10m"
        case precipitation = "precipitation"
    }
}


// MARK: - CurrentUnits
struct CurrentUnits: Codable {
    let time: String
    let interval: String
    let temperature2M: String
    let relativeHumidity2M: String
    let apparentTemperature: String
    let weatherCode: String
    let windSpeed10M: String
    let windDirection10M: String
    let precipitation: String

    enum CodingKeys: String, CodingKey {
        case time
        case interval
        case temperature2M = "temperature_2m"
        case relativeHumidity2M = "relative_humidity_2m"
        case apparentTemperature = "apparent_temperature"
        case weatherCode = "weather_code"
        case windSpeed10M = "wind_speed_10m"
        case windDirection10M = "wind_direction_10m"
        case precipitation = "precipitation"
    }
}


