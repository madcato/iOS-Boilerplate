//
//  UINavigationController+extension.swift
//  lishop-swift-uikit
//
//  Created by Daniel Vela on 6/3/23.
//

import UIKit

extension UINavigationController {
    var previousViewController: UIViewController? {
        viewControllers.count > 1 ? viewControllers[viewControllers.count - 2] : nil
    }
}
