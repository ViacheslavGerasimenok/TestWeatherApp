//
//  RequestManager.swift
//  TestWeatherApp
//
//  Created by Bleiki on 14/09/2023.
//

protocol RequestManager: AnyObject {
    func perform<T: Decodable>(request: Request<T>, completion: @escaping (Result<T, Error>) -> Void)
}

final class RequestManagerImpl: RequestManager {
    
    // MARK: - Singleton
    
    static let shared: RequestManager = RequestManagerImpl()
    
    // MARK: - Init
    
    private init() { }
    
    // MARK: - RequestManager

    func perform<T>(request: Request<T>, completion: @escaping (Result<T, Error>) -> Void) {
        
    }
}
