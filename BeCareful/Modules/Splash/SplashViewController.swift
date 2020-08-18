//
//  SplashViewController.swift
//  BeCareful
//
//  Created by Vladimir Flores on 18/08/20.
//  Copyright © 2020 IA Interactive. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    // MARK: Properties

    internal var router: (NSObjectProtocol & SplashRoutingLogic)?

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        router?.routeToLoginViewController()
    }

}
