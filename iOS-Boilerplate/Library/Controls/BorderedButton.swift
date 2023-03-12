//
//  BorderedButton.swift
//  lishop-swift-uikit
//
//  Created by Daniel Vela on 5/3/23.
//

import UIKit

class BorderedButton: UIButton {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layer.borderWidth = 1.0
        layer.borderColor = AppDelegate.mainColor.cgColor
        layer.cornerRadius = 8.0
        layer.masksToBounds = true
        setTitleColor(AppDelegate.mainColor, for: .normal)
        setTitleColor(UIColor.darkText, for: .highlighted)
    }
}
