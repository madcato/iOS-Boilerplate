//
//  PropertyListHelper.swift
//  BasketPrice
//
//  Created by Daniel Vela on 11/06/2017.
//  Copyright © 2017 Daniel Vela. All rights reserved.
//

import Foundation

class PropertyListHelper {
    static func loadArray(fromFile fileName: String) -> [Any]? {
        if let fileUrl = Bundle.main.url(forResource: fileName,
                                         withExtension: "plist"),
            let data = try? Data(contentsOf: fileUrl) {
            if let result = try? PropertyListSerialization.propertyList(from: data,
                                                                        options: [],
                                                                        format: nil) as? [Any] {
                return result
            }
        }
        return nil
    }
}
