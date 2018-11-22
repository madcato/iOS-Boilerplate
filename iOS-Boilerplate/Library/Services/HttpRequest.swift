//
//  HttpRequest.swift
//  iOS-Boilerplate
//
//  Created by Daniel Vela Angulo on 22/11/2018.
//  Copyright © 2018 veladan. All rights reserved.
//

import Foundation
import Alamofire

enum HTTPRequestMethod {
    case Get
    case Post
}

class HTTPRequest {

    func baseUrl() -> String {
        return Settings.kDefaultProtocol
            + Settings.kDefaultServerHost
            + Settings.kBasePath
    }

    func endpointUrl(endpoint: String) -> String {
        return baseUrl() + endpoint
    }

    //    curl -H 'Content-Type: application/json'
    //        -H 'Accept: application/json'
    //        -H 'secret: aakjsdklfj;ajsdflkajsdkfj'
    //        -X POST http://localhost:3000/api/v1/employee_user/login -d "{\"email\":\"vela.dan@gmail.com\",\"password\":\"tQDJC42S1OmTvnitug9edA\"}"

    func convertMethod(method: HTTPRequestMethod) -> HTTPMethod {
        switch method {
        case .Get:
            return HTTPMethod.get
        case .Post:
            return HTTPMethod.post
        }
    }

    func start(method:HTTPRequestMethod, endpoint: String, parameters: [String:String], onOK: @escaping (Any?) -> (), onError: @escaping (Int, String) -> ()) {
        let headers = [
            "Accept": "application/json",
            "secret": Settings.kApiKey
        ]

        Alamofire.request(endpointUrl(endpoint: endpoint),
                          method: convertMethod(method: method),
                          parameters: parameters,
                          encoding: JSONEncoding(options: []),
                          headers: headers)
            .validate()
            .responseJSON { response in
                guard case let .failure(error) = response.result else { onOK(response.result.value); return; }

                if let error = error as? AFError {
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
                        case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
                            print("Response content type: \(responseContentType) was unacceptable: \(acceptableContentTypes)")
                        case .unacceptableStatusCode(let code):
                            print("Response status code was unacceptable: \(code)")
                        }
                    case .responseSerializationFailed(let reason):
                        print("Response serialization failed: \(error.localizedDescription)")
                        print("Failure Reason: \(reason)")
                    }

                    print("Underlying error: \(error.underlyingError)")
                } else if let error = error as? URLError {
                    print("URLError occurred: \(error)")
                } else {
                    print("Unknown error: \(error)")
                }

                onError(response.response?.statusCode ?? 0,error.localizedDescription)
        }
    }
}

