//
//  PersistenceController.swift
//  Weather-App
//
//  Created by rentamac on 1/27/26.
//

import CoreData

final class PersistenceController {
    
    static let shared = PersistenceController()
    let container: NSPersistentContainer
    
    private init() {
        container = NSPersistentContainer(name: "WeatherModel")
        container.loadPersistentStores { _, error in
            if let error {
                print("Core Data load error:", error.localizedDescription)
            }
        }
    }
    // MARK: Save
    func saveChanges() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Save error:", error.localizedDescription)
            }
        }
    }
    
   
    //  CRUD operations
    
    //MARK: - CREATE
    func createWeather(
        id: UUID,
        name: String,
        latitude: Double,
        longitude: Double,
    ) {
        let context = container.viewContext
        let request: NSFetchRequest<WeatherCache> = WeatherCache.fetchRequest()
        request.predicate = NSPredicate(
            format: "latitude == %lf AND longitude == %lf",
            latitude, longitude
        )
        request.fetchLimit = 1
        let weather = (try? context.fetch(request).first)
        ?? WeatherCache(context: context)
        
        weather.id = id
        weather.name = name
        weather.latitude = latitude
        weather.longitude = longitude
        weather.isSynced = false
        weather.updatedAt = nil
        
        saveChanges()
    }
    // MARK: - FETCH
    func fetchAll() -> [WeatherCache] {
        let request: NSFetchRequest<WeatherCache> = WeatherCache.fetchRequest()
        return (try? container.viewContext.fetch(request)) ?? []
    }
    
    // MARK: - UPDATE (Weather Details from API)
    func updateWeatherDetails(
        for weather: WeatherCache,
        temperature: Double,
        feelsLike: Double,
        humidity: Int,
        windSpeed: Double,
        windDirection: Double
    ) {
        weather.temperature = temperature
        weather.feelsLike = feelsLike
        weather.humidity = Int16(humidity)
        weather.windSpeed = windSpeed
        weather.windDirection = windDirection
        weather.isSynced = true
        weather.updatedAt = Date()
        
        saveChanges()
    }

    // MARK: - RESET WEATHER DATA
    func resetAllWeatherData() {
        let context = container.viewContext
        let request: NSFetchRequest<WeatherCache> = WeatherCache.fetchRequest()

        do {
            let locations = try context.fetch(request)

            locations.forEach { location in
                location.temperature = 0
                location.feelsLike = 0
                location.humidity = 0
                location.windSpeed = 0
                location.windDirection = 0
                location.isSynced = false
                location.updatedAt = nil
            }

            saveChanges()

        } catch {
            print("Failed to reset weather data:", error.localizedDescription)
        }
    }

    
}
