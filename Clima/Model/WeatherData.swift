//
//  WeatherData.swift
//  Clima
//
//  Created by Lukas Adomavicius on 1/5/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    var main: Main
    var name: String
    var weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
}

struct Weather: Decodable {
    var id: Int
}
