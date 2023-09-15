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
    func editLocationsTapped()
    func didSelectItemAt(indexPath: IndexPath)
    func locationModelAt(indexPath: IndexPath) -> LocationModel?
    func deleteLocationTapped(indexPath: IndexPath)
    func renameLocationTapped(indexPath: IndexPath, newName: String)
    func startLocationRenamingProcess(indexPath: IndexPath)
    func startLocationDeletingProcess(indexPath: IndexPath)
}

final class HomePresenterImpl {
    
    // MARK: - Properties
    
    private let out: HomeOut
    private weak var view: HomeView?
    private static let localStorage: LocalStorage = LocalStorageImpl.shared
    
    private var isEditing = false
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
        updateEditButton()
    }
    
    private func updateEditButton() {
        guard !locations.isEmpty else {
            view?.setEditingButton(title: "")
            return
        }
        view?.setEditingButton(title: isEditing ? "End Editing" : "Edit")
    }
    
    private func saveLocations() {
        Self.localStorage.setValue(locations, forKey: .locations)
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
    
    func editLocationsTapped() {
        if isEditing {
            view?.endShakeLocationCells()
        } else {
            view?.startShakeLocationCells()
        }
        isEditing.toggle()
        updateEditButton()
    }
    
    func didSelectItemAt(indexPath: IndexPath) {
        if isEditing {
            view?.showLocationActionsAlert(indexPath: indexPath)
        } else {
            guard let location = locations[safe: indexPath.row] else { return }
            out(.openForecast(location))
        }
    }
    
    func locationModelAt(indexPath: IndexPath) -> LocationModel? {
        locations[safe: indexPath.row]
    }
    
    func renameLocationTapped(indexPath: IndexPath, newName: String) {
        guard !newName.isEmpty else {
            view?.showAlert(title: "Failure", subtitle: "Name shouldn't be empty")
            return
        }
        guard var locationModel = locationModelAt(indexPath: indexPath) else {
            view?.showAlert(title: "Failure", subtitle: "Location not found")
            return
        }
     
        locationModel.name = newName
        locations[indexPath.row] = locationModel
        saveLocations()
        updateView()
        
        view?.showAlert(title: "Success", subtitle: "Location renamed to \(newName)")
    }
    
    func deleteLocationTapped(indexPath: IndexPath) {
        guard let location = locationModelAt(indexPath: indexPath) else {
            view?.showAlert(title: "Failure", subtitle: "Location not found")
            return
        }
        locations.remove(at: indexPath.row)
        saveLocations()
        updateView()
        
        view?.showAlert(title: "Success", subtitle: "Location \(location.name) deleted")
    }
    
    func startLocationRenamingProcess(indexPath: IndexPath) {
        guard let location = locationModelAt(indexPath: indexPath) else { return }
        view?.showRenameAlert(indexPath: indexPath, currentLocationName: location.name)
    }
    
    func startLocationDeletingProcess(indexPath: IndexPath) {
        guard let location = locationModelAt(indexPath: indexPath) else { return }
        view?.showDeleteAlert(indexPath: indexPath, locationName: location.name)
    }
}

// MARK: - HomeIn

extension HomePresenterImpl: HomeIn {
    func addLocation(_ location: LocationModel) {
        locations.append(location)
        saveLocations()
        updateView()
    }
}
