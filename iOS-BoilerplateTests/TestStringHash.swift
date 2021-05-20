//
//  TestStringHash.swift
//  iOS-BoilerplateTests
//
//  Created by Daniel Vela on 20/5/21.
//  Copyright © 2021 veladan. All rights reserved.
//

import XCTest

class TestStringHash: XCTestCase {

    func testMd5() throws {
        let md5 = "Hola Hola".md5()
        XCTAssertEqual(md5, "6c093f1bfb40f2977f89e4d0a7ebb4f3")
        XCTAssertNotEqual(md5, "6c093f1bfb40f2977f89e4d0a7ebb4f2")
    }

    func testSha1() throws {
        let sha1 = "Hola Hola".sha1()
        XCTAssertEqual(sha1, "4df70561b07b8d5c3a750e106bd48b89b94f692d")
        XCTAssertNotEqual(sha1, "4df70561b07b8d5c3a750e106bd48b89b94f692a")
    }

    func testSha256() throws {
        let sha256 = "Hola Hola".sha256()
        XCTAssertEqual(sha256, "dc6617b0ca67e8e21bb55030cc29258af0aa7eb94b4ba99cf61afa106578e8a8")
        XCTAssertNotEqual(sha256, "dc6617b0ca67e8e21bb55030cc29258af0aa7eb94b4ba99cf61afa106578e8a9")
    }
}
