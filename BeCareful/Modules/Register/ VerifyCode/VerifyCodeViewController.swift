//
//  VerifyCodeViewController.swift
//  BeCareful
//
//  Created by Mariana Parente on 29/03/20.
//  Copyright © 2020 Jose Alberto. All rights reserved.
//

import UIKit
import FirebaseMessaging

class VerifyCodeViewController: UIViewController {

    @IBOutlet weak var titleCode: UILabel!
    @IBOutlet weak var code: UITextField!
    @IBOutlet weak var separator: UIView!
    @IBOutlet weak var error: UILabel!

    var idDevice: String = UIDevice.current.identifierForVendor!.uuidString

    override func viewDidLoad() {
        super.viewDidLoad()
        self.code.delegate = self
        self.titleCode.text = titleCode.text! + " " + AppUserDefaults.phoneNumber

    }

    @IBAction func verifyCode(_ sender: UIButton) {

        guard let code = code.text else {
            self.showError()
            return
        }

        if code.count == 4 {
//            let data = RegisterOTP(phone: AppUserDefaults.phoneNumber, idDevice: idDevice, otp: code)
//            APIData.shared.validateRegister(with: data) { (result) in
//            switch result {
//            case .failure(let error):
//                print(error)
//                self.showError()
//            case .success(let register):
//                UserDefaultsManager.shared.isRegister = true
//                UserDefaultsManager.shared.code = register.code
//                UserDefaultsManager.shared.token = register.message
//                DispatchQueue.main.async {
//                    UIStoryboard.loadHome()
//                }
//            }
//        }
        } else {
            showError()
        }

    }

    private func showError() {
        DispatchQueue.main.async {
            self.error.isHidden = false
            self.separator.backgroundColor = .red
        }
    }
}

extension VerifyCodeViewController: UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        separator.backgroundColor = UIColor.smBlue
        error.isHidden = true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        separator.backgroundColor = .black
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        code.endEditing(true)
        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let textFieldText = textField.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= 4
    }
}
