//
//  Mocks.swift
//  BeCareful
//
//  Created by Eduardo Pacheco on 03/06/20.
//  Copyright © 2020 Jose Alberto. All rights reserved.
//

import Foundation

struct Mocks {

    // Register
    static let mockUser: UserID = UserID(phone: "4431231212", idDevice: "123123TEST")
    static let mockErrorUser: UserID = UserID(phone: "0000000000", idDevice: "123123TEST")
    static let mockRegisterStatus: RegisterStatus = RegisterStatus(code: 200, message: "Success")
}
