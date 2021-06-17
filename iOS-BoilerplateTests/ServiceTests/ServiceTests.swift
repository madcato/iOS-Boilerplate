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
//        describe("NetworkRequest") {
//            var networkService: BookNomadsService?
//
//            beforeEach {
//                NetworkingInjector.apiClient = Http.Client(accessToken: Configuration.apiToken)
//                networkService = BookNomadsService()
//            }
//
//            context("get isbn") {
//                it("should return a json of type BookDTO when server response is a json object") {
//                    var book: BookDTO?
//                    networkService?.getBook(by: "9789000010134",
//                                            onOK: { response in
//                                                book = response
//                                            },
//                                            onError: { code, desc in
//                                                print("Error network service" +
//                                                    " for isbn. Error \(code), \(desc)")
//                                            })
//                    expect(book).toEventuallyNot(beNil())
//                    var expectedBook = BookDTO()
//                    expectedBook.authors = [["Name": "Louis"]]
//                    expectedBook.isbn = "9789000010134"
//                    expectedBook.languageCode = "nl"
//                    expectedBook.title = "Speak english"
//                    expectedBook.coverThumb = ""
//                    expectedBook.description = ""
//                    expectedBook.subjects = ["Non-fictie informatief/professioneel algemeen"]
//                    expect(book).to(equal(expectedBook))
//                }
//            }
//        }
//    }
}
