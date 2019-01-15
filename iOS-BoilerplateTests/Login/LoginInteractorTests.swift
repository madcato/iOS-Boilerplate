//
//  LoginInteractorTests.swift
//  iOS-Boilerplate
//
//  Created by Daniel Vela Angulo on 14/01/2019.
//  Copyright (c) 2019 veladan. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import iOS_Boilerplate
import XCTest

class LoginInteractorTests: XCTestCase {
    // MARK: Subject under test

    var sut: LoginInteractor?

    // MARK: Test lifecycle

    override func setUp() {
        super.setUp()
        setupLoginInteractor()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Test setup

    func setupLoginInteractor() {
        sut = LoginInteractor()
    }

    // MARK: Test doubles

    class LoginPresentationLogicSpy: LoginPresentationLogic {

        var presentLoginCalled = false
        var loginOk: Int = 0

        func presentLogin(response: Login.Process.Response) {
            presentLoginCalled = true
            switch response.result {
            case .loginOk:
                loginOk = 1
            case .loginInvalid:
                loginOk = 2
            }
        }

        var presentErrorCalled = false

        func presentError(code: Login.Process.Response.Error, description: String) {
            presentErrorCalled = true
        }
    }

    // MARK: Tests

    func testDoLoginOk() {
        // Given
        let spy = LoginPresentationLogicSpy()
        sut?.presenter = spy
        let request = Login.Process.Request(userName: "dani", password: "1234")

        // When
        sut?.doSignIn(request: request)

        // Then
//        XCTAssertTrue(spy.presentLoginCalled, "testDoLoginOk(request:) should called")
//        XCTAssertTrue(spy.loginOk == 1, "testDoLoginOk(request:) should be login ok")
    }

    func testDoLoginBad() {
        // Given
        let spy = LoginPresentationLogicSpy()
        sut?.presenter = spy
        let request = Login.Process.Request(userName: "dani", password: "4321")

        // When
        sut?.doSignIn(request: request)

        // Then
//        XCTAssertTrue(spy.presentLoginCalled, "testDoLoginOk(request:) should called")
//        XCTAssertTrue(spy.loginOk == 2, "testDoLoginOk(request:) should be login ok")
    }

    func testDoLoginError() {
        // Given
        let spy = LoginPresentationLogicSpy()
        sut?.presenter = spy
        let request = Login.Process.Request(userName: "dani", password: nil)

        // When
        sut?.doSignIn(request: request)

        // Then
        XCTAssertTrue(spy.presentErrorCalled, "doSomething(request:) should ask the presenter to format the result")
    }
}
