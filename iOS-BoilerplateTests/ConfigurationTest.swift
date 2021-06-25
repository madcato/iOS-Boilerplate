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
        XCTAssertEqual(Configuration.value(for: .kServerURLkey), "https://int.server.com")
    }

    func testApiTokenConfiguration() {
        Configuration.environment = Environment.integration
        XCTAssertEqual(Configuration.value(for: .kAPIToken), "2341251251235")
    }

    func testChangeEnviromentConfiguration() {
        Configuration.environment = Environment.production
        XCTAssertEqual(Configuration.value(for: .kServerURLkey), "https://pro.server.com")
        XCTAssertEqual(Configuration.value(for: .kAPIToken), "8281989128282")

        Configuration.environment = Environment.staging
        XCTAssertEqual(Configuration.value(for: .kServerURLkey), "https://stg.server.com")
        XCTAssertEqual(Configuration.value(for: .kAPIToken), "128039471029387")
    }

}
