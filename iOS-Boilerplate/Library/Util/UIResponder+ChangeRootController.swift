//
//  UIAppDelegate+ChangeRootController.swift
//  MobilePay
//
//  Created by Daniel Vela on 02/08/16.
//  Copyright © 2016 Daniel Vela. All rights reserved.
//

import UIKit

extension UIResponder {
    func changeRootControllerTo(_ viewController: UIViewController,
                                window: UIWindow?,
                                onEnd: @escaping (_ ended: Bool) -> Void) {
        guard let window = window else {
            return
        }
        // Show main view with animation
        UIView.transition(with: window,
                          duration: 0.8,
                          options: UIView.AnimationOptions.transitionCrossDissolve,
                          animations: {
            window.rootViewController = viewController
        },
                          completion: { (ended: Bool) in
            onEnd(ended)
        })
    }
}
