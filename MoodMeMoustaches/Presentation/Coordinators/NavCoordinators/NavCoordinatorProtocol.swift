//
//  NavCoordinatorProtocol.swift
//  pethug
//
//  Created by Raul Pena on 13/09/23.
//

import UIKit

protocol NavCoordinator: Coordinator {
    var rootViewController: UINavigationController { get set }
}
