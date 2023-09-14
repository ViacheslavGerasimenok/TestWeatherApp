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
        router.showHome(animated: false, out: processHome)
    }
    
    // MARK: - ProcessFunctions
    
    private func processHome(cmd: HomeOutCmd) {
        switch cmd {
        case .openForecast(let location):
            router.openForecast(location: location, out: processForecast)
        case .openAddLocation:
            router.openAddLocation(out: processAddLocation)
        }
    }
    
    private func processForecast(cmd: ForecastOutCmd) {
        
    }
    
    private func processAddLocation(cmd: AddLocationOutCmd) {
        
    }
}
