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
        XCTAssertEqual(Configuration.environment, Environment.integration)
    }

    func testServerURLConfiguration() {
        XCTAssertEqual(Configuration.serverURL, "http://int.domain.com")
    }

    func testApiTokenConfiguration() {
        XCTAssertEqual(Configuration.apiToken, "token")
    }

    func testChangeEnviromentConfiguration() {
        Configuration.environment = Environment.production
        XCTAssertEqual(Configuration.serverURL, "http://production.domain.com")
        XCTAssertEqual(Configuration.apiToken, "2138901234h12kg435")

        Configuration.environment = Environment.staging
        XCTAssertEqual(Configuration.serverURL, "http://pre.domain.com")
        XCTAssertEqual(Configuration.apiToken, "adsfaf232323c4kjhg234l76")
    }

}
