//
//  Extensions.swift
//  BeCareful
//
//  Created by Jose Alberto on 23/03/20.
//  Copyright © 2020 IA Interactive. All rights reserved.
//

import UIKit

extension UIViewController {

    func showAlert (title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okayButton = UIAlertAction(title: "Aceptar", style: .cancel, handler: nil)
        alert.addAction(okayButton)
        present(alert, animated: true, completion: nil)
     }

}
