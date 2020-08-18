//
//  SplashRouter.swift
//  BeCareful
//
//  Created by Vladimir Flores on 18/08/20.
//  Copyright (c) 2020 Jose Alberto. All rights reserved.
//
//  swiftlint:disable force_cast
//

import UIKit

@objc protocol SplashRoutingLogic {
    func routeToLoginViewController()
}

final class SplashRouter: NSObject, SplashRoutingLogic {

    // MARK: Properties

    weak var viewController: SplashViewController?

    // MARK: - Routing Logic

    func routeToLoginViewController() {
        if AppUserDefaults.isTutorialShown {
            if AppUserDefaults.isRegister {
                AppDelegate.sharedInstance.loadHome()
            } else {
                AppDelegate.sharedInstance.loadRegister()
            }
        } else {
            AppDelegate.sharedInstance.loadTutorial()
        }
    }

}

// MARK: - Module Builder

final class SplashBuilder {

	static func build() -> SplashViewController {
		let id = String(describing: SplashViewController.self)
		let viewController = UIStoryboard.splash.instantiateViewController(withIdentifier: id) as! SplashViewController
        let router = SplashRouter()
        viewController.router = router
        router.viewController = viewController

        return viewController
	}

}
