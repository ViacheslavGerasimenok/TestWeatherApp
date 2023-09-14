//
//  RootCoordinator.swift
//  TestWeatherApp
//
//  Created by Bleiki on 14/09/2023.
//

import UIKit

protocol RootCoordinator: AnyObject, Coordinator {

}

final class RootCoordinatorImpl: RootCoordinator {
    
    // MARK: - Properties
    
    private let router: RootRouter
    
    // MARK: - Init
    
    init(router: RootRouter) {
        self.router = router
    }
    
    convenience init(nc: UINavigationController) {
        self.init(router: RootRouterImpl(nc: nc))
    }
    
    // MARK: - RootCoordinator
    
    func run() {
        router.showHome(animated: false)
    }
}
