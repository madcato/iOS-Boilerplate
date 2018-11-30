//
//  iOS_BoilerplateUITests.swift
//  iOS-BoilerplateUITests
//
//  Created by Daniel Vela Angulo on 21/11/2018.
//  Copyright © 2018 veladan. All rights reserved.
//

import XCTest

class BoilerplateUITests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will
        // make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation
        // - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
            super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAddNewElement() {
        let app = XCUIApplication()
        let currentCellNumber = app.tables.cells.count
        app.navigationBars["Root View Controller"].buttons["AddButtonId"].tap()
        let incrementedCellNumber = app.tables.cells.count
        XCTAssertEqual(currentCellNumber + 1, incrementedCellNumber)
    }

    func testRemoveOneElement() {
        let app = XCUIApplication()
        let rootViewControllerNavigationBar = app.navigationBars["Root View Controller"]
        rootViewControllerNavigationBar.buttons["EditButtonId"].tap()

        let tablesQuery = app.tables
        let currentCellNumber = tablesQuery.cells.count
        tablesQuery.cells.buttons.allElementsBoundByIndex[0].tap()
        tablesQuery.cells.buttons.allElementsBoundByIndex[1].tap()
        rootViewControllerNavigationBar.buttons["OK"].tap()
        let decrementedCellNumber = app.tables.cells.count
        XCTAssertEqual(currentCellNumber - 1, decrementedCellNumber)
    }
}
