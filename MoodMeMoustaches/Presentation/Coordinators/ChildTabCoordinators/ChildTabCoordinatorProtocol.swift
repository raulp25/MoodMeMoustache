//
//  ChildTabCoordinatorProtocol.swift
//  pethug
//
//  Created by Raul Pena on 16/09/23.
//

import Foundation

protocol ChildTabCoordinator: NavCoordinator, ChildControllerManagable {
    var parentCoordinator: InAppCoordinator? { get set }
}
