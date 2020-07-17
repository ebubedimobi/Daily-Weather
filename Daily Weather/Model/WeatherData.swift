//
//  WeatherData.swift
//  Daily Weather
//
//  Created by Ebubechukwu Dimobi on 10.07.2020.
//  Copyright © 2020 blazeapps. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
}

struct Main: Decodable {
    let temp: Double
    
}

struct Weather: Decodable {
    let description: String
    let id: Int
}
