//
//  ForecastPresenter.swift
//  TestWeatherApp
//
//  Created by Bleiki on 14/09/2023.
//

import Foundation

typealias ForecastOut = (ForecastOutCmd) -> Void
enum ForecastOutCmd {
    case goBack
}

protocol ForecastPresenter: AnyObject {
    func viewDidLoad()
    func backTapped()
    func retryTapped()
}

final class ForecastPresenterImpl {
    
    // MARK: - Properties
    
    private let out: ForecastOut
    private let location: LocationModel
    private weak var view: ForecastView?
    private let weatherService = WeatherServiceImpl.shared

    // MARK: - Init
    
    init(
        location: LocationModel,
        view: ForecastView?,
        out: @escaping ForecastOut
    ) {
        self.out = out
        self.view = view
        self.location = location
    }
    
    // MARK: - Helpers
    
    private func requestWeather() {
        view?.startLoading()
        weatherService.requestWeatherFor(location: location) { [weak self] result in
            self?.view?.endLoading()
            switch result {
            case .success(let weather):
                print(weather)
            case .failure(let error):
                self?.view?.showWeatherErrorAlert(error: error)
            }
        }
    }
}

// MARK: - ForecastPresenter

extension ForecastPresenterImpl: ForecastPresenter {
    func viewDidLoad() {
        requestWeather()
    }
    
    func backTapped() {
        out(.goBack)
    }
    
    func retryTapped() {
        requestWeather()
    }
}
