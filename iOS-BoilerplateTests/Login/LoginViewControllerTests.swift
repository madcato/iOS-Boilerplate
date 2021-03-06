//
//  LoginViewControllerTests.swift
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

class LoginViewControllerTests: XCTestCase {
    // MARK: Subject under test

    var sut: LoginViewController?
    var window: UIWindow?

    // MARK: Test lifecycle

    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupLoginViewController()
    }

    override func tearDown() {
        window = nil
        super.tearDown()
    }

    // MARK: Test setup

    func setupLoginViewController() {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Login", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: "LoginViewController")  as? LoginViewController
    }

    func loadView() {
        guard let view = sut?.view else {
            return
        }
        window?.addSubview(view)
        RunLoop.current.run(until: Date())
    }

    // MARK: Test doubles

    class LoginBusinessLogicSpy: LoginBusinessLogic {
        var doSignInCalled = false

        func doSignIn(request: Login.Process.Request) {
            doSignInCalled = true
        }
    }

    // MARK: Tests

//    func testShouldDoSomethingWhenViewIsLoaded() {
//        // Given
//        let spy = LoginBusinessLogicSpy()
//        sut.interactor = spy
//
//        // When
//        loadView()
//
//        // Then
//        XCTAssertTrue(spy.doSignInCalled, "viewDidLoad() should ask the interactor to do something")
//    }
//
//      func testDisplaySomething() {
//          // Given
//          let viewModel = Login.Process.ViewModel(signInOk: true)
//
//          // When
//          loadView()
//          sut.displayLogin(viewModel: viewModel)
//
//          // Then
//          //XCTAssertEqual(sut.nameTextField.text, "", "displaySomething(viewModel:) should update
                // the name text field")
//      }
}
