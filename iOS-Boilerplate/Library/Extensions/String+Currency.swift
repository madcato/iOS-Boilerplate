//
//  CurrencyString.swift
//  lishop-swift-uikit
//
//  Created by Daniel Vela on 9/4/23.
//

import Foundation

extension String {
    func currencyString() -> String {
        guard let value = Double(self) else {
            return ""
        }
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 0
        return formatter.string(for: value) ?? ""
    }
}
