//
//  ServiceTests.swift
//  iOS-BoilerplateTests
//
//  Created by Daniel Vela Angulo on 03/12/2018.
//  Copyright © 2018 veladan. All rights reserved.
//

@testable import iOS_Boilerplate
import Nimble
import Quick
import XCTest

class ServiceTests: QuickSpec {

//    override func spec() {
//
//        let object: JsonObject = [
//            "username": "Rodrigo",
//            "email": "em@il.com",
//            "age": 29
//        ]
//
//        describe("NetworkRequest") {
//
//            var networkService: RealNetworkRequest!
//
//            beforeEach {
//                networkService = RealNetworkRequest()
//            }
//
//            context("get") {
//
//                it("should return a json of type object when server response is a json object") {
//
//                    self.stub(everything, json(object))
//
//                    var jsonResponse: JsonObject? = nil
//
//                    networkService.request(URL(string: "http://www.google.com")!, method: .get, parameters: nil, headers: nil, completion: { (result) in
//                        switch result {
//                        case .success(.object (let response)):
//                            jsonResponse = response
//                        default:
//                            fatalError()
//                        }
//                    })
//
//                    expect(jsonResponse).toEventuallyNot(beNil())
//                }
//
//                it("should return a json of type array when server response is a array of json object") {
//
//                    let array = [object, object, object]
//                    self.stub(everything, json(array))
//
//                    var jsonResponse: [JsonObject]? = nil
//
//                    networkService.request(URL(string: "http://www.google.com")!, method: .get, parameters: nil, headers: nil, completion: { (result) in
//                        switch result {
//                        case .success(.array (let response)):
//                            jsonResponse = response
//                        default:
//                            fatalError()
//                        }
//                    })
//
//                    expect(jsonResponse).toEventuallyNot(beNil())
//                }
//
//                it("should return a error when server response is not a json") {
//
//                    let body = "[[]]"
//                    let bodyData = body.data(using: String.Encoding.utf8)!
//
//                    self.stub(everything, http(download: .content(bodyData)))
//
//                    var errorResponse: Bool = false
//
//                    networkService.request(URL(string: "http://www.google.com")!, method: .get, parameters: nil, headers: nil, completion: { (result) in
//                        switch result {
//                        case .error():
//                            errorResponse = true
//                        default:
//                            fatalError()
//                        }
//                    })
//
//                    expect(errorResponse).toEventuallyNot(beTrue())
//                }
//
//                it("should return a error when server response is a error") {
//
//                    let error = NSError.init(domain: "testing", code: 0, userInfo: nil)
//
//                    self.stub(everything, failure(error))
//
//                    var errorResponse: Error? = nil
//
//                    networkService.request(URL(string: "http://www.google.com")!, method: .get, parameters: nil, headers: nil, completion: { (result) in
//                        switch result {
//                        case .error():
//                            errorResponse = error
//                        default:
//                            fatalError()
//                        }
//                    })
//
//                    expect(errorResponse).toEventuallyNot(beNil())
//                    expect(errorResponse as? NSError).toEventually(equal(error))
//                }
//
//                it("should add the parameters on the url") {
//
//                    let parameters: [String: Any] = [ "project": "Swift",
//                                                      "name": "Testing"]
//
//                    var correctUrl = false
//
//                    let matcher = { (request: URLRequest) -> Bool in
//                        correctUrl = request.url!.absoluteString == "http://www.google.com?name=Testing&project=Swift"
//                        return true
//                    }
//
//                    self.stub(matcher, json(object))
//
//
//                    networkService.request(URL(string: "http://www.google.com")!, method: .get, parameters: parameters, headers: nil, completion: { (result) in
//
//                    })
//
//                    expect(correctUrl).toEventually(beTrue())
//                }
//
//                it("should pass the headers") {
//
//                    let headers: [String: String] = [ "AppKey": "Swift",
//                                                      "AppSecret": "Testing"]
//
//                    var success = true
//
//                    let matcher = { (request: URLRequest) -> Bool in
//                        for (key, value) in headers {
//                            if request.allHTTPHeaderFields![key] != value {
//                                success = false
//                                break
//                            }
//                        }
//                        return true
//                    }
//
//                    self.stub(matcher , json(object))
//
//
//                    networkService.request(URL(string: "http://www.google.com")!, method: .get, parameters: nil, headers: headers, completion: { (result) in
//
//                    })
//
//                    expect(success).toEventually(beTrue())
//                }
//            }
//        }
//    }
}
