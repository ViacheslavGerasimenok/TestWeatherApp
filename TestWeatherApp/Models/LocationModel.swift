//
//  LocationModel.swift
//  TestWeatherApp
//
//  Created by Bleiki on 14/09/2023.
//

struct LocationModel: Codable {
    var name: String
    var latitude: Double
    var longitude: Double
    
    var coordinatesString: String {
        let latitudeString = "Latitude: \(String(format: "%.2f", latitude))"
        let longitudeString = "Longitude: \(String(format: "%.2f", longitude))"
        return "\(latitudeString)\n\(longitudeString)"
    }
}
