//
//  LocalStorage.swift
//  TestWeatherApp
//
//  Created by Bleiki on 14/09/2023.
//

import Foundation

protocol LocalStorage: AnyObject {
    func getValue<T: Decodable>(forKey key: LocalStorageKey) -> T?
    func setValue<T: Encodable>(_ value: T, forKey key: LocalStorageKey)
}

final class LocalStorageImpl: LocalStorage {
    
    // MARK: - Singleton
    
    static let shared = LocalStorageImpl()
    
    // MARK: - Properties
    
    private let userDefaults = UserDefaults.standard
    
    // MARK: - Init
    
    private init() { }

    // MARK: - LocalStorage

    func setValue<T: Encodable>(_ value: T, forKey key: LocalStorageKey) {
        let valueData = try? PropertyListEncoder().encode(value)
        userDefaults.set(valueData, forKey: key.rawValue)
    }
    
    func getValue<T: Decodable>(forKey key: LocalStorageKey) -> T? {
        guard let valueData = userDefaults.value(forKey: key.rawValue) as? Data,
              let value = try? PropertyListDecoder().decode(T.self, from: valueData) else {
            return nil
        }
        return value
    }
}
