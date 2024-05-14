//
//  MockTabCoordinator.swift
//  MoodMeMoustaches
//
//  Created by Raul Pena on 14/05/24.
//

import Foundation

import UIKit

final class MockTabCoordinator: NSObject, ChildTabCoordinator {
    var childCoordinators: [NavCoordinator] = .init()
    
    var parentCoordinator: InAppCoordinator?
    
    var rootViewController: UINavigationController = .init()
    
    func start() {
        let vc = MockVC()
        rootViewController.navigationBar.isHidden = true
        rootViewController.pushViewController(vc, animated: true)
    }
    
}

/// MoodMe ~ UINavigationControllerDelegate - This is just for Reference
//extension MockTabCoordinator: UINavigationControllerDelegate {
//    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
//        // Read the view controller we’re moving from.
//        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
//            return
//        }
//
//        // Check whether our view controller array already contains that view controller. If it does it means we’re pushing a different view controller on top rather than popping it, so exit.
//        if navigationController.viewControllers.contains(fromViewController) {
//            return
//        }
//
//        // We’re still here – it means we’re popping the view controller, so we can check whether it’s a createAccountVc or forgotPasswordVc
//        if let createAccountVc = fromViewController as? CreateAccountViewController {
//            // We're popping a createAccountVc; and its coordinator
//            childDidFinish(createAccountVc.coordinator)
//        } else if let forgotPasswordVc = fromViewController as? ForgotPasswordViewController {
//            // We're popping a forgotPasswordVc; and its coordinator
//            childDidFinish(forgotPasswordVc.coordinator)
//        }
//
//    }
//}
