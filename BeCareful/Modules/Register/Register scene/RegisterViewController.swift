//
//  RegisterViewController.swift
//  BeCareful
//
//  Created by Mariana Parente on 22/03/20.
//  Copyright © 2020 IA Interactive. All rights reserved.
//  swiftlint:disable force_cast
//

import UIKit

class RegisterViewController: UIViewController {

    // MARK: Properties
    var idDevice: String = UIDevice.current.identifierForVendor!.uuidString

    // MARK: Outlets
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var separator: UIView!
    @IBOutlet weak var error: UILabel!

    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneNumber.delegate = self
    }

    // MARK: - Actions
    @IBAction func sendRegister(_ sender: UIButton) {
        guard let phoneNumber = phoneNumber.text else {
            showError()
            return
        }

        switch validatePhone(phoneNumber: phoneNumber) {
        case true:
            goToVerifyCode()
//            let userId = UserID(phone: phoneNumber, IdDevice: idDevice)
//            APIData.shared.registerUser(with: userId) { (result) in
//                switch result {
//                case .failure(let error):
//                    print(error)
//
//                case .success(let register):
//                    DispatchQueue.main.async {
//                        let alert = UIAlertController(title: "", message: register.message, preferredStyle: .alert)
//                        let action = UIAlertAction(title: "Aceptar", style: .default, handler: nil)
//                        alert.addAction(action)
//                        self.present(alert, animated: true, completion: {
//                            UserDefaultsManager.shared.phoneNumber = phoneNumber
//                            self.goToVerifyCode()
//                        })
//                    }
//                }
//            }

        case false:
            showError()
        }
    }

    // MARK: - Private Methods
    private func goToVerifyCode() {
        let storyboard = UIStoryboard.register
        let formVC = storyboard.instantiateViewController(withIdentifier: "verifyCode") as! VerifyCodeViewController
        navigationController?.pushViewController(formVC, animated: true)
    }

    private func validatePhone(phoneNumber: String ) -> Bool {
        let phoneNumberRegex = "^[0-9]{10}$"
        let trimmedString = phoneNumber.trimmingCharacters(in: .whitespaces)
        let validate = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        let isValidPhone = validate.evaluate(with: trimmedString)
        return isValidPhone
    }

    private func showError() {
        error.isHidden = false
        separator.backgroundColor = .red
    }
}

// MARK: - Text Fields Delegate
extension RegisterViewController: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        separator.backgroundColor = UIColor.smBlue
        error.isHidden = true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        separator.backgroundColor = .black
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        phoneNumber.endEditing(true)
        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text, let rangeOfTextToReplace = Range(range, in: textFieldText) else { return false }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= 10
    }
}
