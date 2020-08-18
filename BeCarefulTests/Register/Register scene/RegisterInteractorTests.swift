//
//  RegisterInteractorTests.swift
//  BeCareful
//
//  Created by Eduardo Pacheco on 03/06/20.
//  Copyright (c) 2020 Jose Alberto. All rights reserved.
//

@testable import BeCareful
import XCTest

class RegisterInteractorTests: XCTestCase {

    // MARK: Subject under test
    var sut: RegisterInteractor!

    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        sut = RegisterInteractor()
        sut.networkClient = MockAPIData()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
    }

    // MARK: Test doubles
    class RegisterPresentationLogicSpy: RegisterPresentationLogic {
        var successfulRegisterPresented = false
        var errorPresented = false
        var presentedResponse: RegisterStatus?

        func presentSuccessfulRegister(_ response: Register.RegisterNumber.Response) {
            successfulRegisterPresented = true
            presentedResponse = response.registerResponse
        }

        func presentError() {
            errorPresented = true
        }
    }

    // MARK: Tests **************************************************************************************************

    func testRegisterNumber_IncorrectData() {
        let spy = RegisterPresentationLogicSpy()
        sut.presenter = spy
        let request = Register.RegisterNumber.Request(phoneNumber: "1234")
        sut.requestRegisterNumber(request)
        wait(for: 1.0)

        XCTAssertFalse(spy.successfulRegisterPresented)
        XCTAssertNil(spy.presentedResponse)
        XCTAssertTrue(spy.errorPresented)
    }

    func testRegisterNumber_NetworkError() {
        let spy = RegisterPresentationLogicSpy()
        sut.presenter = spy
        let request = Register.RegisterNumber.Request(phoneNumber: "1234567890")
        sut.requestRegisterNumber(request)
        wait(for: 1.0)

        XCTAssertFalse(spy.successfulRegisterPresented)
        XCTAssertNil(spy.presentedResponse)
        XCTAssertFalse(spy.errorPresented)
    }

    func testRegisterNumber_CorrectResponse() {
        let spy = RegisterPresentationLogicSpy()
        sut.presenter = spy
        let request = Register.RegisterNumber.Request(phoneNumber: Mocks.mockUser.phone)
        sut.requestRegisterNumber(request)
        wait(for: 1.0)

        XCTAssertTrue(spy.successfulRegisterPresented)
        XCTAssertNotNil(spy.presentedResponse)
        XCTAssertEqual(spy.presentedResponse!, Mocks.mockRegisterStatus)
        XCTAssertFalse(spy.errorPresented)
    }

    // MARK: - Private Methods

    private func wait(for duration: TimeInterval) {
        let waitExpectation = expectation(description: "Espera")
        let when = DispatchTime.now() + duration
        DispatchQueue.main.asyncAfter(deadline: when) {
            waitExpectation.fulfill()
        }
        waitForExpectations(timeout: duration + 0.5)
    }
}
