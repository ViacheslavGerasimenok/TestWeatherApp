//
//  SelectedLocationArrowView.swift
//  TestWeatherApp
//
//  Created by Bleiki on 15/09/2023.
//

import UIKit

final class SelectedLocationArrowView: UIView {
    
    // MARK: - Properties
    
    private let fillColor: UIColor
    
    // MARK: - Init
    
    init(fillColor: UIColor) {
        self.fillColor = fillColor
        super.init(frame: .zero)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup
    
    private func setup() {
        backgroundColor = .clear
    }
    
    // MARK: - Draw

    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }

        context.beginPath()
        
        context.move(to: CGPoint(x: rect.minX, y: rect.minY))
        context.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        context.addLine(to: CGPoint(x: (rect.maxX / 2.0), y: rect.maxY))

        context.closePath()

        context.setFillColor(fillColor.cgColor)
        context.fillPath()
    }
}

