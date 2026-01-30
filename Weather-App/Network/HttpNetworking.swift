//
//  HttpNetworking.swift
//  Weather-App
//
//  Created by rentamac on 1/26/26.
//

import Foundation

final class HttpNetworking: Networking {

    func request<T: Decodable>(
        endpoint: APIEndpoint,
        responseType: T.Type
    ) async throws -> T {

        guard let url = endpoint.url else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.setValue("iOS Weather App", forHTTPHeaderField: "User-Agent")

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode(T.self, from: data)
    }

}
