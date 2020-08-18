//
//  RegisterWorkerTests.swift
//  BeCareful
//
//  Created by Eduardo Pacheco on 03/06/20.
//  Copyright (c) 2020 Jose Alberto. All rights reserved.
//

@testable import BeCareful
import XCTest

class RegisterWorkerTests: XCTestCase {

    // MARK: Subject under test
    var sut: RegisterWorker!

    // MARK: Test lifecycle
    override func setUp() {
        super.setUp()
        sut = RegisterWorker()
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: Tests **********************************************************************************************

    /// Tests a string that contains numbers and letters as input.
    /// Should return false
    func testPhoneValidation_AlphanumericInput() {
        let testString = "1234asdf"
        XCTAssertFalse(sut.validatePhone(phoneNumber: testString))
    }

    /// Tests an empty string as input.
    /// Should return false
    func testPhoneValidation_EmptyInput() {
        let testString = ""
        XCTAssertFalse(sut.validatePhone(phoneNumber: testString))
    }

    /// Tests a string that contains less than 10 numbers as input.
    /// Should return false
    func testPhoneValidation_ShortInput() {
        let testString = "1234"
        XCTAssertFalse(sut.validatePhone(phoneNumber: testString))
    }

    /// Tests a string that contains more than 10 numbers as input.
    /// Should return false
    func testPhoneValidation_LongInput() {
        let testString = "1234567890123"
        XCTAssertFalse(sut.validatePhone(phoneNumber: testString))
    }

    /// Tests a string that contains a valid 10 digit phone number as input.
    /// Should return true
    func testPhoneValidation_CorrectInput() {
        let testString = "1234567890"
        XCTAssertTrue(sut.validatePhone(phoneNumber: testString))
    }
}
