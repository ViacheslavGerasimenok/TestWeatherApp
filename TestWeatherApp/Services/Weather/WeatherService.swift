//
//  WeatherService.swift
//  TestWeatherApp
//
//  Created by Bleiki on 15/09/2023.
//

import Foundation

protocol WeatherService: AnyObject {
    func requestWeatherFor(location: LocationModel, completion: @escaping (Result<WeatherDTO, Error>) -> Void)
}

final class WeatherServiceImpl: WeatherService {
    
    // MARK: - Singleton
    
    static let shared: WeatherService = WeatherServiceImpl()
    
    // MARK: - Init
    
    private init() { }
    
    // MARK: - Properties
    
    private let appId = "c2f2c08607cd26e8ed5be7046aabf72a"
    private let metricSystemKey = "metric"
    
    // MARK: - WeatherService
    
    func requestWeatherFor(location: LocationModel, completion: @escaping (Result<WeatherDTO, Error>) -> Void) {
        var url = "https://api.openweathermap.org/data/3.0/onecall?"
        let params: [String: Any] = [
            "lat": location.latitude,
            "lon": location.longitude,
            "appid": appId,
            "units": metricSystemKey
        ]
        
        for param in params {
            url += "\(param.key)&\(param.value)"
        }
        
        guard let requestUrl = URL(string: url) else {
            completion(.failure(NSError(domain: "Failed generate URL", code: 1)))
            return
        }
        
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data else {
                completion(.failure(error ?? NSError(domain: "Failed request weather", code: 2)))
                return
            }
            
            do {
                let weatherDTO = try JSONDecoder().decode(WeatherDTO.self, from: data)
                completion(.success(weatherDTO))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
