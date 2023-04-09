//
//  CurrencyString.swift
//  lishop-swift-uikit
//
//  Created by Daniel Vela on 9/4/23.
//

import Foundation

extension String {
    // formatting text for currency textField
    func currencyString() -> String {
        if let value = Double(self) {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.maximumFractionDigits = 2
            formatter.minimumFractionDigits = 0
            if let str = formatter.string(for: value) {
                return str
            }
        }
        return ""
    }
}
