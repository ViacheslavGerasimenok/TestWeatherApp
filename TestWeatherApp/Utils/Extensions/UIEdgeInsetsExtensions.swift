//
//  UIEdgeInsetsExtensions.swift
//  TestWeatherApp
//
//  Created by Bleiki on 14/09/2023.
//

import UIKit

extension UIEdgeInsets {
    var horizontal: CGFloat {
        left + right
    }
    
    var vertical: CGFloat {
        top + bottom
    }
}
