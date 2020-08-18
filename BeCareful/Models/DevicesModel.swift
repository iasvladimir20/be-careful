//
//  DevicesModel.swift
//  BeCareful
//
//  Created by Israel Filadelfo Calderon Chavez on 29/03/20.
//  Copyright © 2020 Israel Filadelfo Calderon Chavez. All rights reserved.
//

import Foundation
import FirebaseMessaging

struct DeviceModel: Encodable {
    let devices: [DeviceId]
    let token = Messaging.messaging().fcmToken
}

struct DeviceId: Encodable {
    let id: String
}
