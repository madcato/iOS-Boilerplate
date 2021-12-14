//
//  LoginModels.swift
//  iOS-Boilerplate
//
//  Created by Daniel Vela Angulo on 11/01/2019.
//  Copyright (c) 2019 veladan. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

// swiftlint:disable nesting
enum Login {
    enum Process {
        struct Request {
            var userName: String?
            var password: String?
        }
        struct Response {
            enum Result {
                case loginOk             // Login was ok
                case loginInvalid  // Username or password invalid
            }
            enum Error {
                case invalidUserName
                case invalidPassword
                case connection
            }

            var result: Result
        }
        struct ViewModel {
            var signInOk: Bool
        }
    }
}