//
//  ConfigurationTest.swift
//  iOS-BoilerplateTests
//
//  Created by Daniel Vela Angulo on 21/11/2018.
//  Copyright © 2018 veladan. All rights reserved.
//

@testable import iOS_Boilerplate
import XCTest

class ConfigurationTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testServerURLConfiguration() {
        XCTAssertEqual(Configuration.value(for: .kServerURLkey), "https://pro.server.com")
    }

    func testApiTokenConfiguration() {
        XCTAssertEqual(Configuration.value(for: .kAPIToken), "8281989128282")
    }
}
