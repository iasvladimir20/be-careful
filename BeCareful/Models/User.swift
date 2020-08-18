//
//  User.swift
//  BeCareful
//
//  Created by Israel Filadelfo Calderon Chavez on 21/03/20.
//  Copyright © 2020 Israel Filadelfo Calderon Chavez. All rights reserved.
//

import Foundation

struct UserID: Encodable {
    let phone: String
    let idDevice: String
}

struct RegisterStatus: Decodable, Equatable {
    let code: Int
    let message: String

    static func == (lhs: RegisterStatus, rhs: RegisterStatus) -> Bool {
        return lhs.code == rhs.code && lhs.message == rhs.message
    }
}
