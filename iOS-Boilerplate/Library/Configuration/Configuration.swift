//
//  Configuration.swift
//  iOS-Boilerplate
//
//  Created by Daniel Vela Angulo on 21/11/2018.
//  Copyright © 2018 veladan. All rights reserved.
//

import UIKit

class Configuration {
    static var environment: Environment = {
        if let configuration = Bundle.main.object(forInfoDictionaryKey: "Configuration") as? String {
            if configuration == "staging" {
                return Environment.staging
            }
            if configuration == "integration" {
                return Environment.integration
            }
            if configuration == "production" {
                return Environment.production
            }
        }
        return Environment.integration
    }()

    static var serverURL: String {
        return info(with: kServerURLkey)
    }

    static var apiToken: String {
        return info(with: kAPIToken)
    }

    private static func info(with key: String) -> String {
        guard let conf = environmentsConfig[environment.rawValue] else {
            print("Environment \(environment.rawValue) not defined")
            assert(false)
            return ""
        }
        guard let result = conf[key] else {
            print("Key \(key) not defined in enviroments.plist")
            assert(false) // Key not defined in enviroments.plist
            return ""
        }
        return result
    }

    private static let kServerURLkey = "serverURL"
    private static let kAPIToken = "api-token"

    private init() {}

    private static var internalEnvironmentsConfig: [String : [String : String] ]?

    private static var environmentsConfig: [String : [String : String] ] = {
        if let conf = internalEnvironmentsConfig {
            return conf
        }
        if let url = Bundle.main.url(forResource: "environments", withExtension: "plist") {
            do {
                let data = try Data(contentsOf: url)
                let plist = try PropertyListSerialization.propertyList(from: data,
                                                                      options:
                                                            PropertyListSerialization.ReadOptions.init(rawValue: 0),
                                                                      format: nil) as? [String : [String : String]]
                if let result = plist {
                    internalEnvironmentsConfig = result
                    return result
                }
            } catch {
                 print(error)
                assert(false) // Error reading environemnts.plist file
            }
        }
        return [:]
    }()
}
