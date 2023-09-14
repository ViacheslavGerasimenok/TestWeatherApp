//
//  LocalStorage.swift
//  TestWeatherApp
//
//  Created by Bleiki on 14/09/2023.
//

protocol LocalStorage: AnyObject {
    func getValueFor<Value: Codable>(key: String) -> Value?
    func save<Value: Codable>(value: Value, for key: String)
}

final class LocalStorageImpl: LocalStorage {

    // MARK: - LocalStorage

    func getValueFor<Value: Codable>(key: String) -> Value? {
        return nil
    }
    
    func save<Value: Codable>(value: Value, for key: String) {
        
    }
}
