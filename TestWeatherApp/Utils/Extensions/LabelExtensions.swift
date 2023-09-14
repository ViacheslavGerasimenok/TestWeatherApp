//
//  LabelExtensions.swift
//  TestWeatherApp
//
//  Created by Bleiki on 14/09/2023.
//

import UIKit

extension UILabel {
    convenience init(numberOfLines: Int) {
        self.init()
        self.numberOfLines = numberOfLines
    }
}
