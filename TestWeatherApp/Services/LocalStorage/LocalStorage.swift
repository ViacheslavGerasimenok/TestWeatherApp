//
//  LocalStorage.swift
//  TestWeatherApp
//
//  Created by Bleiki on 14/09/2023.
//

import Foundation

protocol LocalStorage: AnyObject {
    func getValueFor<Value: Codable>(key: String) -> Value?
    func save<Value: Codable>(value: Value, for key: String)
}

final class LocalStorageImpl {
    
}

// MARK: - LocalStorage

extension LocalStorageImpl: LocalStorage {
    func getValueFor<Value: Codable>(key: String) -> Value? {
        return nil
    }
    
    func save<Value: Codable>(value: Value, for key: String) {
        
    }
}
