//
//  UIViewExtensions.swift
//  TestWeatherApp
//
//  Created by Bleiki on 14/09/2023.
//

import UIKit

extension UIView {
    var isRegular: Bool {
        traitCollection.horizontalSizeClass == .regular
    }
    
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
    
    func shake(duration: Double = 0.1) {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = duration
        animation.repeatCount = 4
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 1, y: self.center.y + 1))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 1, y: self.center.y - 1))
        self.layer.add(animation, forKey: "position")
    }
}
