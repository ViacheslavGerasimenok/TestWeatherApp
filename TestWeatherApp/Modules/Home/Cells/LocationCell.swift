//
//  LocationCell.swift
//  TestWeatherApp
//
//  Created by Bleiki on 14/09/2023.
//

import UIKit

final class LocationCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private var viewModel: LocationCellViewModel?
    
    private let sideInset: CGFloat = 8
    
    // MARK: - Subviews
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(numberOfLines: 2)
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel(numberOfLines: 2)
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    func configure(viewModel: LocationCellViewModel) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        contentView.addSubviews(titleLabel, subtitleLabel)
        
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 16
        
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    private func setupLayout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: sideInset),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: subtitleLabel.topAnchor, constant: -sideInset),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: sideInset),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -sideInset)
        ])
        
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            subtitleLabel.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -sideInset),
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: sideInset),
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -sideInset)
        ])
    }
}
