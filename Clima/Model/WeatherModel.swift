//
//  WeatherModel.swift
//  Clima
//
//  Created by Lukas Adomavicius on 1/5/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel: Codable {
    let cityName: String
    let responseId: Int
    let temperature: Double
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        switch responseId {
        case 200...299:
            return "cloud.bolt.rain"
        case 300...399:
            return "cloud.drizzle"
        case 500...599:
            return "cloud.rain"
        case 600...699:
            return "cloud.snow"
        case 700...799:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...899:
            return "cloud.bolt"
        default:
            return "NaN"
        }
    }
}
