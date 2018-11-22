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

enum HttpRequestMethod {
    case get
    case post
}

class HttpRequest {

    func baseUrl() -> String {
        return Configuration.serverURL + Configuration.basePath
    }

    func endpointUrl(endpoint: String) -> String {
        return baseUrl() + endpoint
    }

    func customHeaders() -> [String: String] {
        return [:]
    }

    //    curl -H 'Content-Type: application/json'
    //        -H 'Accept: application/json'
    //        -H 'secret: aakjsdklfj;ajsdflkajsdkfj'
    //        -X POST http://localhost:3000/api/v1/employee_user/login -d "{\"email\":\"vela.dan@gmail.com\",
    //                                                                     \"password\":\"tQDJC42S1OmTvnitug9edA\"}"

    func start(method: HttpRequestMethod,
               endpoint: String,
               parameters: [String: String],
               onOK: @escaping (Any?) -> Void,
               onError: @escaping (Int, String) -> Void) {
        var headers = [
            "Accept": "application/json",
            "secret": Configuration.apiToken
        ]
        headers = headers.merging(customHeaders(), uniquingKeysWith: { strA, strB -> String in strB })
        let url = endpointUrl(endpoint: endpoint)
        Alamofire.request(url,
                          method: translate(method: method),
                          parameters: parameters,
                          encoding: JSONEncoding(options: []),
                          headers: [:])
            .validate()
            .responseJSON { response in
                guard case let .failure(error) = response.result else {
                    onOK(response.result.value)
                    return
                }
                self.treat(error)
                onError(response.response?.statusCode ?? 0, error.localizedDescription)
            }
    }

    private func translate(method: HttpRequestMethod) -> HTTPMethod {
        switch method {
        case .get:
            return HTTPMethod.get
        case .post:
            return HTTPMethod.post
        }
    }

    private func treat(_ error: Any?) {
        if let error = error as? AFError {
            treat(afError: error)
        } else if let error = error as? URLError {
            print("URLError occurred: \(error)")
        } else {
            print("Unknown error: \(String(describing: error))")
        }
    }

    private func treat(afError error: AFError) {
        switch error {
        case .invalidURL(let url):
            print("Invalid URL: \(url) - \(error.localizedDescription)")
        case .parameterEncodingFailed(let reason):
            print("Parameter encoding failed: \(error.localizedDescription)")
            print("Failure Reason: \(reason)")
        case .multipartEncodingFailed(let reason):
            print("Multipart encoding failed: \(error.localizedDescription)")
            print("Failure Reason: \(reason)")
        case .responseValidationFailed(let reason):
            print("Response validation failed: \(error.localizedDescription)")
            print("Failure Reason: \(reason)")
            switch reason {
            case .dataFileNil, .dataFileReadFailed:
                print("Downloaded file could not be read")
            case .missingContentType(let acceptableContentTypes):
                print("Content Type Missing: \(acceptableContentTypes)")
            // swiftlint:disable:next pattern_matching_keywords
            case .unacceptableContentType(let acceptableTypes, let responseType):
                print("Response content type: \(responseType) was unacceptable: " + "\(acceptableTypes)")
            case .unacceptableStatusCode(let code):
                print("Response status code was unacceptable: \(code)")
            }
        case .responseSerializationFailed(let reason):
            print("Response serialization failed: \(error.localizedDescription)")
            print("Failure Reason: \(reason)")
        }
        print("Underlying error: \(String(describing: error.underlyingError))")
    }
}
