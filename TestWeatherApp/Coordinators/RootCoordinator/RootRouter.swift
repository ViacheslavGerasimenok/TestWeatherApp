//
//  RootRouter.swift
//  TestWeatherApp
//
//  Created by Bleiki on 14/09/2023.
//

import UIKit

protocol RootRouter: AnyObject {
    func showHome(animated: Bool, out: @escaping HomeOut)
    func openAddLocation(out: @escaping AddLocationOut)
    func openForecast(location: LocationModel, out: @escaping ForecastOut)
}

final class RootRouterImpl: RootRouter {
    
    // MARK: - Properties
    
    private weak var nc: UINavigationController?
    
    // MARK: - Init
    
    init(nc: UINavigationController) {
        self.nc = nc
    }
    
    // MARK: - RootRouter
    
    func showHome(animated: Bool, out: @escaping HomeOut) {
        let homeVC = HomeViewController(out: out)
        nc?.pushViewController(homeVC, animated: animated)
    }
    
    func openAddLocation(out: AddLocationOut) {
        
    }
    
    func openForecast(location: LocationModel, out: @escaping ForecastOut) {
        
    }
}
