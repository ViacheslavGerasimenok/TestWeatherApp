//
//  EmptyView.swift
//  TestWeatherApp
//
//  Created by Bleiki on 14/09/2023.
//

import UIKit

final class EmptyView: UIView {
    
    // MARK: - Properties
    
    private var isFirstLayout = true

    // MARK: - Subviews
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(numberOfLines: 0)
        label.text = title
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Properties
    
    var title: String = "" {
        didSet {
            titleLabel.text = title
        }
    }
    
    // MARK: - LifeCycle
    
    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        setupViews()
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        backgroundColor = .white
        addSubview(titleLabel)
    }
    
    private func setupLayout() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .sideInset),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.sideInset)
        ])
    }
}
