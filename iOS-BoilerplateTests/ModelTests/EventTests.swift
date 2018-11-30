//
//  EventTests.swift
//  iOS-BoilerplateTests
//
//  Created by Daniel Vela Angulo on 30/11/2018.
//  Copyright © 2018 veladan. All rights reserved.
//

@testable import iOS_Boilerplate
import UIKit
import XCTest

class EventTests: ModelHelper {
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testQuery() {
        guard let date = Date.fromJSON("2018-11-29T16:17:32.000") else {
            return
        }
        let event: Event? = database?.getObjectFrom("Event", Where(predicate: "timestamp == %@", arguments: [date]))
        XCTAssertNotNil(event)
    }

    func testQueryNotExists() {
        guard let date = Date.fromJSON("2018-11-20T16:17:32.000") else {
            return
        }
        let event: Event? = database?.getObjectFrom("Event", Where(predicate: "timestamp == %@", arguments: [date]))
        XCTAssertNil(event)
    }

    func testCreation() {
        let numberOfEvents = database?.count("Event") ?? -10
        let event: Event? = database?.createObject()
        event?.timestamp = Date()
        database?.saveContext()
        XCTAssertEqual(numberOfEvents + 1, database?.count("Event") ?? -20)
    }

    func testDeletion() {
        guard let date = Date.fromJSON("2018-11-29T16:17:32.000") else {
            return
        }
        let numberOfEvents = database?.count("Event") ?? -10
        let event: Event? = database?.getObjectFrom("Event", Where(predicate: "timestamp == %@", arguments: [date]))
        database?.saveContext()
        XCTAssertNotNil(event)
        if let event = event {
            database?.delete(event)
        }
        XCTAssertEqual(numberOfEvents - 1, database?.count("Event") ?? -20)
    }

    func testUpdate() {
        guard let date = Date.fromJSON("2018-11-29T16:17:32.000") else {
            return
        }
        let numberOfEvents = database?.count("Event") ?? -10
        let event: Event? = database?.getObjectFrom("Event", Where(predicate: "timestamp == %@", arguments: [date]))
        event?.timestamp = Date()
        database?.saveContext()
        XCTAssertNotNil(event)
        XCTAssertEqual(numberOfEvents, database?.count("Event") ?? -20)
    }
}
