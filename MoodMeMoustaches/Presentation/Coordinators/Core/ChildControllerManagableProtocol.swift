//
//  ChildControllerManagable.swift
//  pethug
//
//  Created by Raul Pena on 13/09/23.
//

import Foundation

protocol ChildControllerManagable: AnyObject {
    var  childCoordinators: [NavCoordinator] { get set }
    func childDidFinish(_ child: NavCoordinator?)
    
}

extension ChildControllerManagable {
    func childDidFinish(_ child: NavCoordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() where coordinator === child {
            childCoordinators.remove(at: index)
            break
        }
    }
}
