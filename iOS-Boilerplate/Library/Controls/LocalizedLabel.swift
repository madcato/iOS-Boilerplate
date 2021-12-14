//
//  LocalizedLabel.swift
//  iOS-Boilerplate
//
//  Created by Daniel Vela on 13/12/21.
//  Copyright © 2021 veladan. All rights reserved.
//

import UIKit

/**
 Use this class to set it in the storyboard, in the Identity Inspector, in Custom class.
 This class do an auto localization from the label you set in the Storyboard/Xib
 */
class LocalizedLabel: UILabel {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        if let text = self.text {
            let label = LocalizedString(label: text)
            self.text = label.localize()
        }
    }
}
