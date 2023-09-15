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
    
    private weak var homeIn: HomeIn?
    
    // MARK: - Init
    
    init(router: RootRouter) {
        self.router = router
    }
    
    convenience init(nc: UINavigationController) {
        self.init(router: RootRouterImpl(nc: nc))
    }
    
    // MARK: - RootCoordinator
    
    func run() {
        homeIn = router.showHome(animated: false, out: processHome)
    }
    
    // MARK: - ProcessFunctions
    
    private func processHome(cmd: HomeOutCmd) {
        switch cmd {
        case .openForecast(let location):
            router.openForecast(location: location, animated: true, out: processForecast)
        case .openAddLocation:
            router.openAddLocation(animated: true, out: processAddLocation)
        }
    }
    
    private func processForecast(cmd: ForecastOutCmd) {
        switch cmd {
        case .goBack:
            router.pop(animated: true)
        }
    }
    
    private func processAddLocation(cmd: AddLocationOutCmd) {
        switch cmd {
        case .addLocation(let location):
            homeIn?.addLocation(location)
            router.pop(animated: true)
        }
    }
}
