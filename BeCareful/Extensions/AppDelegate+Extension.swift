//
//  AppDelegate+Extension.swift
//  BeCareful
//
//  Created by Vladimir Flores on 18/08/20.
//  Copyright © 2020 IA Interactive. All rights reserved.
//  swiftlint:disable force_cast
//

import UIKit

extension AppDelegate {

    // MARK: Singleton
    static var sharedInstance: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

    // MARK: - App Routing Methods

    func loadTutorial() {
        let iphoneStoryboard = UIStoryboard.tutorial
        let navViewController = iphoneStoryboard.instantiateInitialViewController() as! TutorialViewController
        setControllerAsRoot(navViewController)
    }

    func loadHome() {
        let iphoneStoryboard = UIStoryboard.home
        let navViewController = iphoneStoryboard.instantiateInitialViewController() as! UITabBarController
        setControllerAsRoot(navViewController)
    }

    func loadRegister() {
        let iphoneStoryboard = UIStoryboard.register
        let navViewController = iphoneStoryboard.instantiateInitialViewController() as! UINavigationController
        setControllerAsRoot(navViewController)
    }

    // MARK: - Private Methods

    private func setControllerAsRoot(_ viewController: UIViewController) {
        guard let window = window else { return }
        window.subviews.forEach { $0.removeFromSuperview() }
        window.rootViewController = viewController
        window.makeKeyAndVisible()
        UIView.transition(with: window, duration: 0.75, options: .transitionCrossDissolve, animations: nil, completion: nil)
    }

}
