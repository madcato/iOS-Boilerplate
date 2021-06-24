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
            context("get Marchar character") {
                it("should fail") {
                    let mock = MockAPIClient()
                    mock.objectToReturn = Http.Result.error(1, "fallo")
                    NetworkingInjector.apiClient = mock

                    self.apiClient.request(MarvelAPI.character(2)) { result in
                        switch result {
                        case .success:
                            XCTFail("This request must fail")
                        case let .error(code, _):
                            XCTAssertEqual(code, 1)
                        }
                    }
                }

                it("should success") {
                    let characterDTO = Marvel.ResponseDto(code: 1,
                                                          status: "200",
                                                          copyright: "copy",
                                                          attributionText: nil,
                                                          attributionHTML: nil,
                                                          etag: nil)
                    let mock = MockAPIClient()
                    mock.objectToReturn = Http.Result.success(characterDTO)
                    NetworkingInjector.apiClient = mock

                    self.apiClient.request(MarvelAPI.character(1)) { result in
                        switch result {
                        case let .success(character):
                            XCTAssertEqual(character.copyright, "copy")
                        case .error:
                            XCTFail("This request must success")
                        }
                    }
                }
            }
        }
    }
}
