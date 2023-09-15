//
//  Router.swift
//  TestWeatherApp
//
//  Created by Bleiki on 15/09/2023.
//

import UIKit

protocol Router: AnyObject {
    var nc: UINavigationController? { get }
    
    func pop(animated: Bool)
}

extension Router {
    func pop(animated: Bool) {
        nc?.popViewController(animated: animated)
    }
}
