//
//  RegisterViewControllerTests.swift
//  BeCareful
//
//  Created by Eduardo Pacheco on 03/06/20.
//  Copyright (c) 2020 Jose Alberto. All rights reserved.
//

@testable import BeCareful
import XCTest

class RegisterViewControllerTests: XCTestCase {

    // MARK: Subject under test
    var sut: RegisterViewController!
    var window: UIWindow!

    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupRegisterViewController()
    }

    override func tearDown() {
        window = nil
        super.tearDown()
    }

    // MARK: Test setup
    func setupRegisterViewController() {
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Register", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController
    }

    func loadView() {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }

    // MARK: Test doubles
    class RegisterBusinessLogicSpy: RegisterBusinessLogic {
        var networkClient: APIProtocol! = MockAPIData()
        var registerRequested = false
        var requestedNumber: String?

        func requestRegisterNumber(_ request: Register.RegisterNumber.Request) {
            registerRequested = true
            requestedNumber = request.phoneNumber
        }
    }

    // MARK: Tests *************************************************************************************************

    func testRequestRegister() {
        let spy = RegisterBusinessLogicSpy()
        sut.interactor = spy
        loadView()
        let numberToTest = "1231231231"
        sut.phoneNumberField.text = numberToTest
        sut.sendRegister(UIButton())

        XCTAssertTrue(spy.registerRequested)
        XCTAssertNotNil(spy.requestedNumber)
        XCTAssertEqual(spy.requestedNumber!, numberToTest)
    }

    func testDisplaySuccessRegister() {
        let nav = UINavigationController(rootViewController: sut)
        let spy = RegisterBusinessLogicSpy()
        sut.interactor = spy
        loadView()
        let viewModel = Register.RegisterNumber.ViewModel(responseMessage: "Test Message")
        sut.displaySuccessfulRegister(viewModel)
        wait(for: 1.0)

        XCTAssertNotNil(nav.presentedViewController is UIAlertController)
    }

    func testDisplayError() {
        let spy = RegisterBusinessLogicSpy()
        sut.interactor = spy
        loadView()
        sut.displayError()

        XCTAssertFalse(sut.error.isHidden)
        XCTAssertEqual(sut.separator.backgroundColor, UIColor.red)
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
