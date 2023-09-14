//
//  ForecastViewController.swift
//  TestWeatherApp
//
//  Created by Bleiki on 14/09/2023.
//

import UIKit

protocol ForecastView: AnyObject {
    
}

final class ForecastViewController: UIViewController {
    
    // MARK: - Properties
    
    private var presenter: ForecastPresenter?

    // MARK: - Subviews

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
    }
    
    private func setupLayout() {

    }
}

// MARK: - ForecastView

extension ForecastViewController: ForecastView {

}
