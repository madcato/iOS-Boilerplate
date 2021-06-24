//
//  MarvelDetailTests.swift
//  MarvelDetailTests
//
//  Created by Daniel Vela on 14/4/21.
//

@testable import iOS_Boilerplate
import XCTest

class MarvelDetailTests: XCTestCase {

    func testListCharacters() {
        let expectation = XCTestExpectation(description: "MarvelService")
        var characterListResult: [Marvel.CharacterDto]?
        MarvelService().listCharacters { result in
            switch result {
            case let .success(response):
                XCTAssertGreaterThan(response.count, 0)
                characterListResult = response
                expectation.fulfill()
            case let .error(id, string):
                print("Error: \(id), \(string)")
            }
        }
        wait(for: [expectation], timeout: 10.0)
        XCTAssertNotNil(characterListResult)
    }

    func testCharacter() {
        let id = 1_011_334
        let expectation = XCTestExpectation(description: "MarvelService")
        var character: Marvel.CharacterDto?
        MarvelService().characterDetail(of: id) { result in
            switch result {
            case let .success(response):
                character = response
                expectation.fulfill()
            case let .error(id, string):
                print("Error: \(id), \(string)")
            }
        }
        wait(for: [expectation], timeout: 10.0)
        XCTAssertNotNil(character)
    }

}
