//
//  ModelHelper.swift
//  iOS-BoilerplateTests
//
//  Created by Daniel Vela Angulo on 30/11/2018.
//  Copyright © 2018 veladan. All rights reserved.
//

@testable import iOS_Boilerplate
import XCTest

class ModelHelper: XCTestCase {
    var database: CoreDataStack?

    override func setUp() {
        super.setUp()
        database = CoreDataStack(modelName: "iOS_Boilerplate", testing: true)
        loadFixtures()
    }

    override func tearDown() {
        super.tearDown()
        database = nil
    }

    func loadFileToData(_ name: String, ofType: String) -> Data? {
        let testBundle = Bundle(for: type(of: self))
        if let path = testBundle.path(forResource: name, ofType: ofType) {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                return data
            }
        }
        return nil
    }

    func loadFixtures() {
        testLoadEvents()
    }

    func testLoadEvents() {
        if let data = loadFileToData("Event", ofType: "json"),
            let array: [EventDTO] = EventDTO.decode(array: data) {
            for eventDTO in array {
                let event: Event? = database?.createObject()
                event?.timestamp = Date.fromJSON(eventDTO.timestamp)
                }
            database?.saveContext()
        } else {
            XCTFail("File not loaded")
        }
    }
}
