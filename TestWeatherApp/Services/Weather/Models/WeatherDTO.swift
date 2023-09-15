//
//  WeatherModel.swift
//  TestWeatherApp
//
//  Created by Bleiki on 15/09/2023.
//

import Foundation

struct WeatherDTO: Codable {
    let current: WeatherCurrentDTO
}

struct WeatherCurrentDTO: Codable {
    let humidity: Double
    let temperature: Double
    
    let windGust: Double
    let windSpeed: Double
    let windDirectionDegrees: Double
    
    enum CodingKeys: String, CodingKey {
        case humidity
        case temperature = "temp"
        
        case windGust = "wind_gust"
        case windSpeed = "wind_speed"
        case windDirectionDegrees = "wind_deg"
    }
}
