//
//  ForecastPresenter.swift
//  TestWeatherApp
//
//  Created by Bleiki on 14/09/2023.
//

import Foundation

typealias ForecastOut = (ForecastOutCmd) -> Void
enum ForecastOutCmd {

}

protocol ForecastPresenter: AnyObject {
    func viewDidLoad()
}

final class ForecastPresenterImpl {
    
    // MARK: - Properties
    
    private let out: ForecastOut
    private let location: LocationModel
    private weak var view: ForecastView?

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
}

// MARK: - ForecastPresenter

extension ForecastPresenterImpl: ForecastPresenter {
    func viewDidLoad() {
        
    }
}
