//
//  EarthquakeModel.swift
//  CombineExample
//
//  Created by Erva Hatun Tekeoğlu on 19.09.2023.
//

import Foundation

struct EarthquakeModel: Codable {
    let results: [Earthquake]
}
struct Earthquake: Codable {
    let timestamp: String
    let latitude, longitude, depth, size: Double
    let quality: Double
    let humanReadableLocation: String
}
