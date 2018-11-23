//
//  UIViewController+showAlert.swift
//  OSFramework
//
//  Created by Daniel Vela on 19/04/2017.
//  Copyright © 2017 Daniel Vela. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(_ message: String, title: String? = nil, onFinish: @escaping () -> Void = {}) {
        if #available(iOS 8.0, *) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in onFinish() })
            self.present(alert, animated: true) {}
        } else {
            let alertView = UIAlertView(title: nil, message: message, delegate: nil, cancelButtonTitle: "OK")
            alertView.show()
        }
    }

    static func showAlertOnTopController(_ message: String,
                                         title: String? = nil,
                                         onFinish: @escaping () -> Void = {}) {
        var rootViewController = UIApplication.shared.keyWindow?.rootViewController
        if let navigationController = rootViewController as? UINavigationController {
            rootViewController = navigationController.viewControllers.first
        }
        if let tabBarController = rootViewController as? UITabBarController {
            rootViewController = tabBarController.selectedViewController
        }
        rootViewController?.showAlert(message, title: title, onFinish: onFinish)
    }
}
