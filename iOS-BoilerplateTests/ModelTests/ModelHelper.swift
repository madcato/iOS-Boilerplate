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

    func loadFixtures() {
        
    }
}
