//
//  Dictionarizable.swift
//  iOS-Boilerplate
//
//  Created by Daniel Vela on 15/8/23.
//  Copyright © 2023 veladan. All rights reserved.
//

import Foundation

public protocol Dictionarizable {
    var dictionarized: [String: Any] { get }
}

public extension Dictionarizable {
    /// Convert to arrays, one with the keys and other with the values, into a Dictionary<String:Any>
    /// Removes nil values
    func dictionarize(_ keys: [String], _ values: [Any?]) -> [String: Any] {
        let keysAndValues = zip(keys, values)
        return keysAndValues.reduce(into: [String: Any]()) { partialResult, pair in
            guard pair.1 != nil else {
                return
            }
            partialResult[pair.0] = pair.1
        }
    }
}
