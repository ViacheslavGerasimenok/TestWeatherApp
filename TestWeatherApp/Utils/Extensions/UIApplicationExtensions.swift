//
//  UIApplicationExtensions.swift
//  TestWeatherApp
//
//  Created by Bleiki on 14/09/2023.
//

import UIKit

extension UIApplication {
    static var isRegular: Bool {
        shared.keyWindow?.traitCollection.horizontalSizeClass == .regular
    }
}
