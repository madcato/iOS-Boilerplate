//
//  BookNomadsServiceTests.swift
//  iOS-BoilerplateTests
//
//  Created by Daniel Vela Angulo on 22/11/2018.
//  Copyright © 2018 veladan. All rights reserved.
//

@testable import iOS_Boilerplate
import XCTest

class BookNomadsServiceTests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

//    func testIsbn() {
//        let expectation = XCTestExpectation(description: "BookNomadsService")
//        var result: BookDTO?
//        BookNomadsService().getBook(by: "9789000010134",
//                                    onOK: { book in
//                                        result = book
//                                        expectation.fulfill()
//                                    },
//                                    onError: { _, _ in
//                                        expectation.fulfill()
//        })
//        wait(for: [expectation], timeout: 10.0)
//        XCTAssertNotNil(result)
//    }
}
