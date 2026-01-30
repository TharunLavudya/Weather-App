//
//  GeoRequest.swift
//  Weather-App
//
//  Created by rentamac on 1/30/26.
//

import Foundation

struct GeoRequest: APIEndpoint {

    let query: String

    var baseURL: String {
        "https://geocoding-api.open-meteo.com"
    }

    var path: String {
        "/v1/search"
    }

    var queryItems: [URLQueryItem] {
        [
            URLQueryItem(name: "name", value: query),
            URLQueryItem(name: "count", value: "3")
        ]
    }
}
