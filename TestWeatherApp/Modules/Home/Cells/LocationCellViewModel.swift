//
//  LocationCellViewModel.swift
//  TestWeatherApp
//
//  Created by Bleiki on 14/09/2023.
//

struct LocationCellViewModel {
    let title: String
    let subtitle: String
    
    init(location: LocationModel) {
        title = location.name
        subtitle = location.coordinatesString
    }
}
