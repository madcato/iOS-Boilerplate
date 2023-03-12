//
//  UIView+animateLabel.swift
//  lishop-swift-uikit
//
//  Created by Daniel Vela on 12/3/23.
//

import UIKit

extension UIView {
    func animate(_ label: UILabel, with newValue: String?, startColor: UIColor, endColor: UIColor) {
        guard label.text?.isEmpty == false else {
            label.text = newValue
            return
        }
        if label.text != newValue {
            UIView.transition(with: label,
                              duration: 0.4,
                              options: UIView.AnimationOptions.transitionCrossDissolve,
                              animations: {
                label.text = newValue
                label.textColor = startColor
            }, completion: { _ in
                UIView.transition(with: label,
                                  duration: 0.4,
                                  options: UIView.AnimationOptions.transitionCrossDissolve) {
                    label.textColor = endColor
                }
            })
        }
    }
}
