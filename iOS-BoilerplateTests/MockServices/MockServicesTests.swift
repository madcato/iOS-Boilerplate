//
//  MockServicesTests.swift
//  iOS-BoilerplateTests
//
//  Created by Daniel Vela Angulo on 05/12/2018.
//  Copyright © 2018 veladan. All rights reserved.
//

// swiftlint:disable closure_body_length

@testable import iOS_Boilerplate
import Nimble
import Quick
import XCTest

class MockServicesTests: QuickSpec, NetworkingInjected {
    override func spec() {
        describe("MockServicesTests") {
            context("get isbn") {
                it("should fail") {
                    let mock = MockAPIClient()
                    mock.objectToReturn = Http.Result.error(1, "fallo")
                    NetworkingInjector.apiClient = mock

                    self.apiClient.request(API.bookNomadsISBN("isbn")) { result in
                        switch result {
                        case .success:
                            XCTFail("This request must fail")
                        case let .error(code, _):
                            XCTAssertEqual(code, 1)
                        }
                    }
                }

                it("should success") {
                    let bookDTO = BookDTO(isbn: "",
                                          title: "response",
                                          subtitle: "",
                                          description: "",
                                          coverThumb: "",
                                          languageCode: "",
                                          subjects: [],
                                          authors: [])
                    let mock = MockAPIClient()
                    mock.objectToReturn = Http.Result.success(bookDTO)
                    NetworkingInjector.apiClient = mock

                    self.apiClient.request(API.bookNomadsISBN("isbn")) { result in
                        switch result {
                        case let .success(book):
                            XCTAssertEqual(book.title, "response")
                        case .error:
                            XCTFail("This request must success")
                        }
                    }
                }
            }
        }
    }
}
