//
//  Configuration.swift
//  iOS-Boilerplate
//
//  Created by Daniel Vela Angulo on 21/11/2018.
//  Copyright © 2018 veladan. All rights reserved.
//

import UIKit

enum ConfigurationKey: String {
    case kServerURLkey = "serverURL"
    case kAPIToken = "api-token"
    case kAPIPrivateToken = "private-api-token"
    case kBasePath = "basePath"
}

class Configuration {
    static func value(for key: ConfigurationKey) -> String {
        guard let result = environmentsConfig[key.rawValue] else {
            fatalError("Key \(key) not defined in enviroments.plist")  // Key not defined in enviroments.plist
        }
        return result
    }

    private init() {}

    private static var internalEnvironmentsConfig: [String: String] = [:]

    private static var environmentsConfig: [String: String] = {
        let conf = internalEnvironmentsConfig
        if conf.isEmpty == false {
            return conf
        }
        if let url = Bundle.main.url(forResource: "environments", withExtension: "plist") {
            do {
                let data = try Data(contentsOf: url)
                let prop = PropertyListSerialization.ReadOptions(rawValue: 0)
                let plist = try PropertyListSerialization.propertyList(from: data,
                                                                       options: prop,
                                                                       format: nil)
                    as? [String: String]
                if let result = plist {
                    internalEnvironmentsConfig = result
                    return result
                }
            } catch {
                fatalError(error.localizedDescription)  // Error reading environemnts.plist file
            }
        }
        return [:]
    }()
}
