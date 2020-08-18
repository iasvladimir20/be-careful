//
//  RegisterWorker.swift
//  BeCareful
//
//  Created by Eduardo Pacheco on 03/06/20.
//  Copyright (c) 2020 IA Interactive. All rights reserved.
//

import Foundation

class RegisterWorker {

    // MARK: - Public Methods

    func validatePhone(phoneNumber: String) -> Bool {
        let phoneNumberRegex = "^[0-9]{10}$"
        let trimmedString = phoneNumber.trimmingCharacters(in: .whitespaces)
        let validate = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        let isValidPhone = validate.evaluate(with: trimmedString)
        return isValidPhone
    }
}
