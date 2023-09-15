//
//  AddLocationPresenter.swift
//  TestWeatherApp
//
//  Created by Bleiki on 14/09/2023.
//

import CoreLocation

typealias AddLocationOut = (AddLocationOutCmd) -> Void
enum AddLocationOutCmd {
    case addLocation(LocationModel)
}

protocol AddLocationPresenter: AnyObject {
    func viewDidLoad()
    func addButtonTapped(coordinates: CLLocationCoordinate2D)
    func didEnterLocation(name: String)
}

final class AddLocationPresenterImpl {
    
    // MARK: - Properties
    
    private let out: AddLocationOut
    private weak var view: AddLocationView?
    private let localStorage = LocalStorageImpl.shared
    
    private var selectedCoordinates: CLLocationCoordinate2D?
    
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.distanceFilter = kCLDistanceFilterNone
        manager.desiredAccuracy = kCLLocationAccuracyKilometer
        return manager
    }()
    
    private var storedLocations: [LocationModel] {
        localStorage.getValue(forKey: .locations) ?? []
    }
    
    // MARK: - Init
    
    init(
        view: AddLocationView?,
        out: @escaping AddLocationOut
    ) {
        self.out = out
        self.view = view
    }
}

// MARK: - AddLocationPresenter

extension AddLocationPresenterImpl: AddLocationPresenter {
    func viewDidLoad() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        view?.showSelectedLocationView()
    }
    
    func addButtonTapped(coordinates: CLLocationCoordinate2D) {
        selectedCoordinates = coordinates
        view?.showEnterLocationNameAlert()
    }
    
    func didEnterLocation(name: String) {
        guard !name.isEmpty else {
            view?.showErrorAlert(title: "Failure", subtitle: "Name shouldn't be empty")
            return
        }
        
        guard !storedLocations.contains(where: { $0.name == name }) else {
            view?.showErrorAlert(title: "Failure", subtitle: "'\(name)' name already in used")
            return
        }
        
        guard let selectedCoordinates else { return }
        
        let locationModel = LocationModel(
            name: name,
            latitude: selectedCoordinates.latitude,
            longitude: selectedCoordinates.longitude
        )
        out(.addLocation(locationModel))
    }
}
