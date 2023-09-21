//
//  APICaller.swift
//  CombineExample
//
//  Created by Erva Hatun Tekeoğlu on 19.09.2023.
//

import Foundation
import Combine

class APICaller {
    static let shared = APICaller()

    func fetchEarthquakes() -> AnyPublisher<EarthquakeModel, Error> {
        let url = URL(string: "https://apis.is/earthquake/is")!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: EarthquakeModel.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
