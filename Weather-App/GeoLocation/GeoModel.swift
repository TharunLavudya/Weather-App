//
//  GeoModel.swift
//  Weather-App
//
//  Created by rentamac on 1/30/26.
//
import Foundation

struct GeoResponse: Codable {
    let results: [GeoResult]?
}

struct GeoResult: Codable, Identifiable {
    let id = UUID()
    let name: String
    let latitude: Double
    let longitude: Double
    let country: String?
}
