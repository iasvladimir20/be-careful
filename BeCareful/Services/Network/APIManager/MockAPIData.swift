//
//  MockAPIData.swift
//  BeCareful
//
//  Created by Eduardo Pacheco on 03/06/20.
//  Copyright © 2020 Jose Alberto. All rights reserved.
//

import Foundation

final class MockAPIData: APIProtocol {

    // MARK: Public Methods
    func registerUser(with id: UserID, result: @escaping (Result<RegisterStatus, APIServiceError>) -> Void) {
        if id.phone == Mocks.mockUser.phone {
            result(.success(Mocks.mockRegisterStatus))
        } else {
            result(.failure(APIServiceError.invalidResponse))
        }
    }

    func validateRegister(with data: RegisterOTP, result: @escaping (Result<RegisterOTPStatus, APIServiceError>) -> Void) {
        // TODO:
        result(.failure(.apiError))
    }

    func send(devices: DeviceModel, result: @escaping (Result<RegisterStatus, APIServiceError>) -> Void) {
        // TODO:
        result(.failure(.apiError))
    }
}
