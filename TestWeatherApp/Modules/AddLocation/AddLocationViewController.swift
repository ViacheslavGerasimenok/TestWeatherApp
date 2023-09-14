//
//  AddLocationViewController.swift
//  TestWeatherApp
//
//  Created by Bleiki on 14/09/2023.
//

import UIKit

protocol AddLocationView: AnyObject {
    
}

final class AddLocationViewController: UIViewController {
    
    // MARK: - Properties
    
    private var presenter: AddLocationPresenter?

    // MARK: - Subviews

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
        view.backgroundColor = .white
    }
    
    private func setupLayout() {

    }
}

// MARK: - ForecastView

extension AddLocationViewController: AddLocationView {

}
