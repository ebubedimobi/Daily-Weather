//
//  WeatherModule.swift
//  Daily Weather
//
//  Created by Ebubechukwu Dimobi on 10.07.2020.
//  Copyright © 2020 blazeapps. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let description: String
    
    var temperatureString: String{
        return String(format: "%.0f", temperature)
    }
    
    var conditionName: String{
           switch conditionId {
            case 200...232:
                return "cloud.bolt.rain"
            case 300...321:
                return "cloud.drizzle"
            case 500...531:
                return "cloud.heavyrain"
            case 600...622:
                return "cloud.snow"
            case 800:
                return "sun.max"
            case 801...804:
                return "cloud"
            case 701...781:
                return "cloud.fog"
            default:
                return "cloud"
    }
    

    }
}
