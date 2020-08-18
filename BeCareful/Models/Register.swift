//
//  Register.swift
//  BeCareful
//
//  Created by Israel Filadelfo Calderon Chavez on 21/03/20.
//  Copyright © 2020 Israel Filadelfo Calderon Chavez. All rights reserved.
//

import Foundation
import FirebaseMessaging

struct RegisterOTP: Encodable {
    let phone: String
    let idDevice: String
    let otp: String
    let firebaseToken = Messaging.messaging().fcmToken
}

struct RegisterOTPStatus: Decodable {
    let code: Int
    let token: String
    let message: String
}
