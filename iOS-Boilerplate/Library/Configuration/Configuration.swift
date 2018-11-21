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
            if configuration == "Staging" {
                return Environment.staging
            }
            if configuration == "Integration" {
                return Environment.integration
            }
            if configuration == "Production" {
                return Environment.production
            }
        }
        return Environment.integration
    }()

//    static var serverURL: String {
//        switch(environment) {
//        case .production
//        }
//    }

    private lazy var enviroments
    private lazy var productionConfig: [String : String] = {
        if let path = Bundle.main.path(forResource: "production", ofType: "plist") {
            return Dictionary.init(contentsOfFile: path)
        }
        return Dictionary()
    }()
    private init() {}
}
