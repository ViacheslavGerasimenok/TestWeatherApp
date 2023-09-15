//
//  ForecastViewController.swift
//  TestWeatherApp
//
//  Created by Bleiki on 14/09/2023.
//

import UIKit

protocol ForecastView: AnyObject {
    func endLoading()
    func startLoading()
    func showWeatherErrorAlert(error: Error)
}

final class ForecastViewController: UIViewController {
    
    // MARK: - Properties
    
    private var presenter: ForecastPresenter?

    // MARK: - Subviews
    
    private lazy var loader = UIActivityIndicatorView()

    // MARK: - Life Cycle
    
    init(location: LocationModel, out: @escaping ForecastOut) {
        super.init(nibName: nil, bundle: .main)
        presenter = ForecastPresenterImpl(location: location, view: self, out: out)
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
        navigationItem.title = "Forecast"
        view.backgroundColor = .white
        view.addSubview(loader)
    }
    
    private func setupLayout() {
        loader.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

// MARK: - ForecastView

extension ForecastViewController: ForecastView {
    func endLoading() {
        DispatchQueue.main.async {
            self.loader.stopAnimating()
        }
    }
    
    func startLoading() {
        DispatchQueue.main.async {
            self.loader.startAnimating()
        }
    }
    
    func showWeatherErrorAlert(error: Error) {
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Error",
                message: error.localizedDescription,
                preferredStyle: .alert
            )
            
            let backAction = UIAlertAction(title: "Back", style: .default) { [weak self] _ in
                self?.presenter?.backTapped()
            }
            
            let retryAction = UIAlertAction(title: "Retry", style: .default) { [weak self] _ in
                self?.presenter?.retryTapped()
            }
            
            alert.addAction(backAction)
            alert.addAction(retryAction)
            
            self.present(alert, animated: true)
        }
    }
}
