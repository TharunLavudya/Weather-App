//
//  Networking.swift
//  Weather-App
//
//  Created by rentamac on 1/26/26.
//

protocol Networking {
    func request<T: Decodable>(
        endpoint: APIEndpoint,
        responseType: T.Type
    ) async throws -> T
}
