//
//  RootRouter.swift
//  TestWeatherApp
//
//  Created by Bleiki on 14/09/2023.
//

import UIKit

protocol RootRouter: AnyObject {
    func showHome(animated: Bool)
}

final class RootRouterImpl: RootRouter {
    
    // MARK: - Properties
    
    private weak var nc: UINavigationController?
    
    // MARK: - Init
    
    init(nc: UINavigationController) {
        self.nc = nc
    }
    
    // MARK: - RootRouter
    
    func showHome(animated: Bool) {
        let homeVC = HomewViewController(nibName: nil, bundle: .main)
        nc?.pushViewController(homeVC, animated: animated)
    }
}
