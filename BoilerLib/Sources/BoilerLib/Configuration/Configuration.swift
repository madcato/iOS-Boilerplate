//
//  Configuration.swift
//  iOS-Boilerplate
//
//  Created by Daniel Vela Angulo on 21/11/2018.
//  Copyright © 2018 veladan. All rights reserved.
//

import UIKit

class Configuration {
    enum Key: String {
        case serverURL = "serverURL"
        case apiToken = "api-token"
        case apiPrivateToken = "private-api-token"
        case basePath = "basePath"
        case environment = "environment"
    }

    static func value(for key: Key) -> String {
        guard let result = (Bundle.main.infoDictionary?[key.rawValue] as? String)?
            .replacingOccurrences(of: "\\", with: "") else {
            fatalError("Environment variable \(key.rawValue) not found or incorrect format in \"Info.plist\"")
        }
        return result
    }

    private init() {}
}
