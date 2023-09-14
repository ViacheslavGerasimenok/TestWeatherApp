//
//  AppDelegate.swift
//  TestWeatherApp
//
//  Created by Bleiki on 14/09/2023.
//

import UIKit

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Properties

    var window: UIWindow?
    
    private var rootCoordinator: RootCoordinator?
    private var appConfigurator: AppConfigurator?
    
    // MARK: - UIApplicationDelegate

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        setupApp()
        return true
    }
}

// MARK: - SetupFunctions

private extension AppDelegate {
    func setupApp() {
        let rootNC = UINavigationController()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootNC
        window?.makeKeyAndVisible()
        
        rootCoordinator = RootCoordinatorImpl(nc: rootNC)
        rootCoordinator?.run()
        
        appConfigurator = AppConfiguratorImpl()
        appConfigurator?.configure()
    }
}
