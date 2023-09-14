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
}
