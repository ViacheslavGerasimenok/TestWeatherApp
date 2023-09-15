//
//  HomePresenter.swift
//  TestWeatherApp
//
//  Created by Bleiki on 14/09/2023.
//

import Foundation

typealias HomeOut = (HomeOutCmd) -> Void
enum HomeOutCmd {
    case openForecast(LocationModel)
    case openAddLocation
}

protocol HomeIn: AnyObject {
    func addLocation(_ location: LocationModel)
}

protocol HomePresenter: AnyObject {
    var locationsCount: Int { get }
    
    func viewDidLoad()
    func addLocationTapped()
    func didSelectItemAt(indexPath: IndexPath)
    func locationModelAt(indexPath: IndexPath) -> LocationModel?
}

final class HomePresenterImpl {
    
    // MARK: - Properties
    
    private let out: HomeOut
    private weak var view: HomeView?
    private static let localStorage: LocalStorage = LocalStorageImpl.shared
    
    private var locations: [LocationModel]
    
    // MARK: - Init
    
    init(
        view: HomeView?,
        out: @escaping HomeOut
    ) {
        self.out = out
        self.view = view
        self.locations = Self.localStorage.getValue(forKey: .locations) ?? []
    }
    
    // MARK: - Helpers
    
    private func updateView() {
        view?.reloadData()
        view?.setEmptyView(isHidden: !locations.isEmpty)
    }
}

// MARK: - HomePresenter

extension HomePresenterImpl: HomePresenter {
    var locationsCount: Int {
        locations.count
    }
    
    func viewDidLoad() {
        updateView()
    }
    
    func addLocationTapped() {
        out(.openAddLocation)
    }
    
    func didSelectItemAt(indexPath: IndexPath) {
        guard let location = locations[safe: indexPath.row] else { return }
        out(.openForecast(location))
    }
    
    func locationModelAt(indexPath: IndexPath) -> LocationModel? {
        locations[safe: indexPath.row]
    }
}

// MARK: - HomeIn

extension HomePresenterImpl: HomeIn {
    func addLocation(_ location: LocationModel) {
        locations.append(location)
        Self.localStorage.setValue(locations, forKey: .locations)
        updateView()
    }
}
