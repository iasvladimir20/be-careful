//
//  RegisterPresenterTests.swift
//  BeCareful
//
//  Created by Eduardo Pacheco on 03/06/20.
//  Copyright (c) 2020 Jose Alberto. All rights reserved.
//

@testable import BeCareful
import XCTest

class RegisterPresenterTests: XCTestCase {

    // MARK: Subject under test
    var sut: RegisterPresenter!

    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        sut = RegisterPresenter()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Test doubles
    class RegisterDisplayLogicSpy: RegisterDisplayLogic {
        var succesfulRegisterDisplayed = false
        var errorDisplayed = false
        var displayedMessage: String?

        func displaySuccessfulRegister(_ viewModel: Register.RegisterNumber.ViewModel) {
            succesfulRegisterDisplayed = true
            displayedMessage = viewModel.responseMessage
        }

        func displayError() {
            errorDisplayed = true
        }
    }

    // MARK: Tests ****************************************************************************************************

    func testPresentRegister() {
        let spy = RegisterDisplayLogicSpy()
        sut.viewController = spy
        let response = Register.RegisterNumber.Response(registerResponse: Mocks.mockRegisterStatus)
        sut.presentSuccessfulRegister(response)

        XCTAssertTrue(spy.succesfulRegisterDisplayed)
        XCTAssertNotNil(spy.displayedMessage)
        XCTAssertEqual(spy.displayedMessage!, Mocks.mockRegisterStatus.message)
        XCTAssertFalse(spy.errorDisplayed)
    }

    func testPresentError() {
        let spy = RegisterDisplayLogicSpy()
        sut.viewController = spy
        sut.presentError()

        XCTAssertFalse(spy.succesfulRegisterDisplayed)
        XCTAssertNil(spy.displayedMessage)
        XCTAssertTrue(spy.errorDisplayed)
    }
}
