//
//  ViewModel.swift
//  Weather-App
//
//  Created by rentamac on 1/22/26.

import Foundation
import Combine
import CoreData

final class ViewModel: ObservableObject {

    @Published var searchText: String = ""
    @Published private(set) var locations: [WeatherCache] = []

    private let db = PersistenceController.shared
    private var cancellables = Set<AnyCancellable>()

    init() {
        loadLocations()

        NotificationCenter.default.publisher(
            for: .NSManagedObjectContextDidSave,
            object: db.container.viewContext
        )
        .receive(on: RunLoop.main)
        .sink { [weak self] _ in
            self?.loadLocations()
        }
        .store(in: &cancellables)

        // Search handling
        $searchText
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .sink { [weak self] _ in
                self?.loadLocations()
            }
            .store(in: &cancellables)
    }

    func loadLocations() {
        let all = db.fetchAll()

        if searchText.isEmpty {
            locations = all
        } else {
            locations = all.filter {
                ($0.name ?? "")
              .localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    // Resets the data
    func resetWeatherData() {
        PersistenceController.shared.resetAllWeatherData()
    }


}

