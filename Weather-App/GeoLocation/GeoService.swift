//
//  GeoService.swift
//  Weather-App
//
//  Created by rentamac on 1/30/26.
//

protocol GeoServiceProtocol {
    func searchCity(name: String) async throws -> [GeoResult]
}

final class GeoService: GeoServiceProtocol {

    private let networking: Networking

    init(networking: Networking = HttpNetworking()) {
        self.networking = networking
    }

    func searchCity(name: String) async throws -> [GeoResult] {
        let endpoint = GeoRequest(query: name)
        let response = try await networking.request(
            endpoint: endpoint,
            responseType: GeoResponse.self
        )
        return response.results ?? []
    }
}
