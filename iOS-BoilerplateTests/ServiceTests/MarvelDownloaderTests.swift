//
//  MarvelDownloaderTests.swift
//  iOS-BoilerplateTests
//
//  Created by Daniel Vela on 15/8/23.
//  Copyright © 2023 veladan. All rights reserved.
//

@testable import BLUtility
@testable import iOS_Boilerplate
import XCTest

// IMPORTANT: Launch this tests only manually
// to avoid internet queries wait time
final class MarvelDownloaderTests: XCTestCase {
    var downloader: MarvelDownloader?
    var database: CoreDataStack?
    var service: MarvelService?

    override func setUpWithError() throws {
        database = CoreDataStack(modelName: "iOS_Boilerplate", testing: true)
        service = MarvelService()
        downloader = MarvelDownloader(with: database!, and: service!)
    }

    func testFirstDownload() async throws {
        try await downloader?.downloadAndStoreCharacters()
        let count = MarvelCharacter.count(in: database!)
        XCTAssertEqual(count, 100)
    }

    func testTwoDownloads() async throws {
        try await downloader?.downloadAndStoreCharacters()
        var count = MarvelCharacter.count(in: database!)
        XCTAssertEqual(count, 100)

        // Second download must not change number of characters
        try await downloader?.downloadAndStoreCharacters()
        count = MarvelCharacter.count(in: database!)
        XCTAssertEqual(count, 100)
    }
}
