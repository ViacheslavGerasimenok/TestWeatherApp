//
//  RootRouter.swift
//  TestWeatherApp
//
//  Created by Bleiki on 14/09/2023.
//

import UIKit

protocol RootRouter: AnyObject, Router {
    func showHome(animated: Bool, out: @escaping HomeOut) -> HomeIn?
    func openAddLocation(animated: Bool, out: @escaping AddLocationOut)
    func openForecast(location: LocationModel, animated: Bool, out: @escaping ForecastOut)
}

final class RootRouterImpl: RootRouter {
    
    // MARK: - Properties
    
    private(set) weak var nc: UINavigationController?
    
    // MARK: - Init
    
    init(nc: UINavigationController) {
        self.nc = nc
    }
    
    // MARK: - RootRouter
    
    func showHome(animated: Bool, out: @escaping HomeOut) -> HomeIn? {
        let homeVC = HomeViewController(out: out)
        nc?.pushViewController(homeVC, animated: animated)
        return homeVC.presenter
    }
    
    func openAddLocation(animated: Bool, out: @escaping AddLocationOut) {
        let addLocationVC = AddLocationViewController(out: out)
        nc?.pushViewController(addLocationVC, animated: animated)
    }
    
    func openForecast(location: LocationModel, animated: Bool, out: @escaping ForecastOut) {
        let forecastVC = ForecastViewController(location: location, out: out)
        nc?.pushViewController(forecastVC, animated: animated)
    }
}
