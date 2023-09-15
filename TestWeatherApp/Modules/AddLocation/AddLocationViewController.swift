//
//  AddLocationViewController.swift
//  TestWeatherApp
//
//  Created by Bleiki on 14/09/2023.
//

import UIKit
import MapKit

protocol AddLocationView: AnyObject {
    func showErrorAlert(title: String, subtitle: String)
    func showSelectedLocationView()
    func showEnterLocationNameAlert()
}

final class AddLocationViewController: UIViewController {
    
    // MARK: - Properties
    
    private var presenter: AddLocationPresenter?

    // MARK: - Subviews
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.delegate = self
        mapView.showsUserLocation = true
        return mapView
    }()
    
    private lazy var selectedLocationView: SelectedLocationView = {
        let view = SelectedLocationView()
        view.isHidden = true
        return view
    }()

    // MARK: - Life Cycle
    
    init(out: @escaping AddLocationOut) {
        super.init(nibName: nil, bundle: .main)
        presenter = AddLocationPresenterImpl(view: self, out: out)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
        presenter?.viewDidLoad()
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        navigationItem.title = "Add Location"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Add",
            style: .done,
            target: self,
            action: #selector(addButtonTapped)
        )
        
        view.backgroundColor = .white
        view.addSubviews(mapView, selectedLocationView)
    }
    
    private func setupLayout() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        selectedLocationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            selectedLocationView.centerXAnchor.constraint(equalTo: mapView.centerXAnchor),
            selectedLocationView.bottomAnchor.constraint(equalTo: mapView.centerYAnchor),
            selectedLocationView.heightAnchor.constraint(equalToConstant: 60),
            selectedLocationView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    // MARK: - Helpers
    
    @objc private func addButtonTapped() {
        presenter?.addButtonTapped(coordinates: mapView.centerCoordinate)
    }
}

// MARK: - ForecastView

extension AddLocationViewController: AddLocationView {
    func showErrorAlert(title: String, subtitle: String) {
        let alert = UIAlertController(
            title: title,
            message: subtitle,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    func showSelectedLocationView() {
        selectedLocationView.isHidden = false
    }
    
    func showEnterLocationNameAlert() {
        let alert = UIAlertController(
            title: "Enter Name",
            message: "Will be used as the display name of the location",
            preferredStyle: .alert
        )
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let addAction = UIAlertAction(title: "Add", style: .default) { [weak alert, weak self] action in
            guard let locationName = alert?.textFields?.first?.text else { return }
            self?.presenter?.didEnterLocation(name: locationName)
        }
        
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        alert.addTextField { textField in
            textField.placeholder = "Name"
        }
        
        present(alert, animated: true)
    }
}

// MARK: - MKMapViewDelegate

extension AddLocationViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        let region = MKCoordinateRegion(center: userLocation.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        selectedLocationView.title = "Calculating..."
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let centerCoordinate = mapView.centerCoordinate
        let latitudeString = "Latitude: \(String(format: "%.2f", centerCoordinate.latitude))"
        let longitudeString = "Longitude: \(String(format: "%.2f", centerCoordinate.longitude))"
        selectedLocationView.title = "\(latitudeString)\n\(longitudeString)"
    }
}
