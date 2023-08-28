//
//  MarvelServiceTests.swift
//  iOS-BoilerplateTests
//
//  Created by Daniel Vela on 15/8/23.
//  Copyright © 2023 veladan. All rights reserved.
//

@testable import iOS_Boilerplate
import XCTest

// IMPORTANT: Launch this tests only manually
// to avoid internet queries wait time
final class MarvelServiceTests: XCTestCase {
    var service: MarvelService!

    override func setUpWithError() throws {
        service = MarvelService()
    }

    func testCharacterList() async throws {
        let characterList = try await service.listCharacters()
        XCTAssertGreaterThan(characterList.count, 0)
    }

    func testCharacterListLimited() async throws {
        let query = Marvel.CharacterListQuery(limit: 3)
        let characterList = try await service.listCharacters(query)
        XCTAssertEqual(characterList.count, 3)
    }

    func testCharacterListLookingForNames() async throws {
        let query = Marvel.CharacterListQuery(nameStartsWith: "Cap")
        let characterList = try await service.listCharacters(query)
        XCTAssertGreaterThan(characterList.count, 0)
        characterList.forEach { character in
            XCTAssertTrue(character.name?.starts(with: "Cap") ?? false)
        }
    }

    func testCharacter() async throws {
        let id = 1_011_334
        let result = try await service.characterDetail(with: id)
        XCTAssertNotNil(result)
    }
}
