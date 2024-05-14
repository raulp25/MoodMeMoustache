//
//  RecordVidTabCoordinator.swift
//  rs5
//
//  Created by Raul Pena on 10/05/24.
//

import UIKit

final class RecordVideoTabCoordinator: NSObject, ChildTabCoordinator {
    var childCoordinators: [NavCoordinator] = .init()
    
    var parentCoordinator: InAppCoordinator?
    
    var rootViewController: UINavigationController = .init()
    //VieModel class instance gets shared across this module vc's
    //    let viewModel: PetsViewModel =
    
    func start() {
        let vc = RecordVideoContainerViewController()
        //        vc.delegate = self
        rootViewController.navigationBar.isHidden = true
        rootViewController.pushViewController(vc, animated: true)
    }
}
