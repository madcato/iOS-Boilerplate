//
//  LocalizedString.swift
//  iOS-Boilerplate
//
//  Created by Daniel Vela on 13/12/21.
//  Copyright © 2021 veladan. All rights reserved.
//

import UIKit

/// Use this class to hold in the models or view models any field that stores a label to be translated.
struct LocalizedString {
    var label: String

    /// Returns the localization of a label.
    func localize() -> String {
        NSLocalizedString(label, comment: "")
    }
}

extension LocalizedString: ExpressibleByStringLiteral {
    init(stringLiteral value: StringLiteralType) {
        label = value
    }
}

extension UILabel {
    static func <= (_ label: UILabel, _ textLabel: LocalizedString) {
        label.text = textLabel.localize()
    }
}
