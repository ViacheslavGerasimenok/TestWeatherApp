//
//  ArrayExtensions.swift
//  TestWeatherApp
//
//  Created by Bleiki on 14/09/2023.
//


extension Array {
    subscript (safe index: Int) -> Element? {
        indices ~= index ? self[index] : nil
    }
}
