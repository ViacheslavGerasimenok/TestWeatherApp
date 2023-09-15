//
//  SelectedLocationView.swift
//  TestWeatherApp
//
//  Created by Bleiki on 15/09/2023.
//

import UIKit

final class SelectedLocationView: UIView {
    
    // MARK: - Properties
    
    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    private let sideInset: CGFloat = 8
    private let fillColor: UIColor = .lightGray
    private let arrowWidth: CGFloat = 18
    private let arrowHeight: CGFloat = 8
    
    // MARK: - Subviews
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(numberOfLines: 0)
        label.text = title
        label.font = .systemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    private lazy var arrowView = SelectedLocationArrowView(fillColor: fillColor)
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = fillColor
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        return view
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup

    private func setupViews() {
        backgroundView.addSubview(titleLabel)
        addSubviews(backgroundView, arrowView)
    }
    
    private func setupLayout() {
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: arrowView.topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: sideInset),
            titleLabel.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: -sideInset),
            titleLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: sideInset),
            titleLabel.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -sideInset)
        ])
        
        arrowView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            arrowView.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor),
            arrowView.bottomAnchor.constraint(equalTo: bottomAnchor),
            arrowView.heightAnchor.constraint(equalToConstant: arrowHeight),
            arrowView.widthAnchor.constraint(equalToConstant: arrowWidth)
        ])
    }
}
