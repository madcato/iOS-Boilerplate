//
//  MarvelDetailTests.swift
//  MarvelDetailTests
//
//  Created by Daniel Vela on 14/4/21.
//

@testable import iOS_Boilerplate
import XCTest

class MarvelDetailTests: XCTestCase {

    func testListCharacters() async {
        do {
            let result = try await MarvelService().listCharacters()
            XCTAssertGreaterThan(result.count, 0)
        } catch {
            XCTAssertTrue(false)
        }
    }

    func testCharacter() async {
        let id = 1_011_334
        do {
            let result = try await MarvelService().characterDetail(with: id)
            XCTAssertNotNil(result)
        } catch {
            XCTAssertTrue(false)
        }
    }

}
