//
//  SnapshotUITests.swift
//  SnapshotUITests
//
//  Created by Daniel Vela Angulo on 23/03/2020.
//  Copyright © 2020 veladan. All rights reserved.
//

import XCTest

class SnapshotUITests: XCTestCase {

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
    }

    override func tearDown() {
        super.tearDown()
    }

//    func testSnapshot() {
//        let app = XCUIApplication()
//        snapshot("01MainScreen")
//        app.navigationBars["Root View Controller"].buttons["Login"].tap()
//        app.tables.buttons["Sign in"].tap()
//        snapshot("02LoginScreen")
//        app.alerts.scrollViews.otherElements.buttons["OK"].tap()
//        snapshot("03LoginFailScreen")
//    }
}
