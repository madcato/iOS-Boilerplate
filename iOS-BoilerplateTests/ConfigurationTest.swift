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

    func testConfiguration() {
        Configuration.environment = Environment.integration
        XCTAssertEqual(Configuration.environment, Environment.integration)
    }

    func testServerURLConfiguration() {
        Configuration.environment = Environment.integration
        XCTAssertEqual(Configuration.serverURL, "https://gateway.marvel.com")
    }

    func testApiTokenConfiguration() {
        Configuration.environment = Environment.integration
        XCTAssertEqual(Configuration.apiToken, "a42b6d2f81c8ca1d0c30e5c99149b8f5")
    }

    func testChangeEnviromentConfiguration() {
        Configuration.environment = Environment.production
        XCTAssertEqual(Configuration.serverURL, "https://gateway.marvel.com")
        XCTAssertEqual(Configuration.apiToken, "a42b6d2f81c8ca1d0c30e5c99149b8f5")

        Configuration.environment = Environment.staging
        XCTAssertEqual(Configuration.serverURL, "https://gateway.marvel.com")
        XCTAssertEqual(Configuration.apiToken, "a42b6d2f81c8ca1d0c30e5c99149b8f5")
    }

}
