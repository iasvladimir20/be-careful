//
//  UserDefaults.swift
//  BeCareful
//
//  Created by Eduardo Pacheco on 03/06/20.
//  Copyright © 2020 IA Interactive. All rights reserved.
//

import Foundation
import UIKit

// MARK: Property Wrapper for User Defaults
@propertyWrapper
struct WrappedUserDefault<T> {

    // MARK: Properties
    let key: String
    let defaultValue: T

    // MARK: Init
    init(_ key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }

    // MARK: Wrapped Value
    var wrappedValue: T {
        get { return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue }
        set { UserDefaults.standard.set(newValue, forKey: key) }
    }
}

// MARK: - Defaults
struct AppUserDefaults {

    @WrappedUserDefault("isTutorialShown", defaultValue: false)
    static var isTutorialShown: Bool

    @WrappedUserDefault("isRegister", defaultValue: false)
    static var isRegister: Bool

    @WrappedUserDefault("phoneNumber", defaultValue: "")
    static var phoneNumber: String

    @WrappedUserDefault("token", defaultValue: "")
    static var token: String

    @WrappedUserDefault("code", defaultValue: 0)
    static var code: Int
}
