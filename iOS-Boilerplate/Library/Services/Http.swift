//
//  HttpRequest.swift
//  iOS-Boilerplate
//
//  Created by Daniel Vela Angulo on 22/11/2018.
//  Copyright © 2018 veladan. All rights reserved.
//

import Alamofire
import Foundation
import UIKit

enum Http {

enum Result<Response> {
    case success(Response)
    case error(Int, String)
}

enum Method {
    case get
    case post
    case put
    case patch
    case delete
}

// MARK: - Http Endpoint

typealias Parameters = [String: Any]
typealias Path = String

final class Endpoint<Response> {
    let method: Method
    let path: Path
    let parameters: Parameters?
    let decode: (Data) throws -> Response

    init(method: Method,
         path: Path,
         parameters: Parameters? = nil,
         decode: @escaping (Data) throws -> Response) {
        self.method = method
        self.path = path
        self.parameters = parameters
        self.decode = decode
    }
}

// MARK: - Http Request

//class Request {
//
//    func baseUrl() -> String {
//        return Configuration.serverURL + Configuration.basePath
//    }
//
//    func endpointUrl(endpoint: String) -> String {
//        return baseUrl() + endpoint
//    }
//
//    func customHeaders() -> [String: String] {
//        return [:]
//    }
//
//    //    curl -H 'Content-Type: application/json'
//    //        -H 'Accept: application/json'
//    //        -H 'secret: aakjsdklfj;ajasdfghlkajsdkfj'
//    //        -X POST http://localhost:3000/api/v1/employee_user/login -d "{\"email\":\"vela.dan@gmail.com\",
//    //                                                                     \"password\":\"tQDJC43S1OmTvnitug9edA\"}"
//}

}  // struct Http

// MARK: - Endpoint extensions

extension Http.Endpoint where Response: Swift.Decodable {
    convenience init(method: Http.Method,
                     path: Http.Path,
                     parameters: Http.Parameters? = nil) {
        self.init(method: method, path: path, parameters: parameters) {
            try JSONDecoder().decode(Response.self, from: $0)
        }
    }
}

extension Http.Endpoint where Response == Void {
    convenience init(method: Http.Method,
                     path: Http.Path,
                     parameters: Http.Parameters? = nil) {
        self.init(
            method: method,
            path: path,
            parameters: parameters) { _ in () }
    }
}
