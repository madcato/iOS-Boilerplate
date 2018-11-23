//
//  PersonDTOTests.swift
//  iOS-BoilerplateTests
//
//  Created by Daniel Vela Angulo on 21/11/2018.
//  Copyright © 2018 veladan. All rights reserved.
//

@testable import iOS_Boilerplate
import XCTest

class PersonDTOTests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDecode() {
        let mainBundle = Bundle(for: PersonDTO.self)
        let fileURL = mainBundle.url(forResource: "person", withExtension: "json")
        XCTAssertNotNil(fileURL)
        do {
            guard let fileURL = fileURL else {
                return
            }
            let jsonData = try Data(contentsOf: fileURL)
            let person = PersonDTO.decode(jsonData: jsonData)
            XCTAssertNotNil(person)
            guard let person2 = person else {
                return
            }
            XCTAssertEqual(person2.name, "Dani")
            XCTAssertEqual(person2.title, "Paster of the Universe")
            XCTAssertEqual(person2.email, "dani@dani")
            XCTAssertEqual(person2.userId, 23)
            XCTAssertNil(person2.id)
        } catch {
            print(error)
        }

    }

    func testEncode() {
        let person = PersonDTO()
        let data = person.encode()
        XCTAssertNotNil(data)
    }
}
