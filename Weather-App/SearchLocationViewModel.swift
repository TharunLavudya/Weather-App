//
//  SearchLocationViewModel.swift
//  Weather-App
//
//  Created by rentamac on 1/30/26.
//
import Combine
import SwiftUI

@MainActor
final class SearchLocationViewModel: ObservableObject {

    @Published var searchText = ""
    @Published var results: [GeoResult] = []
    @Published var isLoading = false

    private let service: GeoServiceProtocol

    init(service: GeoServiceProtocol) {
        self.service = service
    }

    func search() async {
        guard searchText.count >= 3 else {
            results = []
            return
        }

        isLoading = true
        defer { isLoading = false }

        do {
            results = try await service.searchCity(name: searchText)
        } catch {
            results = []
        }
    }
}
