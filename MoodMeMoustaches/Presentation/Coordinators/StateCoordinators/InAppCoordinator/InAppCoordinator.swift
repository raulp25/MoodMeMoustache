//
//  InAppCoordinator.swift
//  pethug
//
//  Created by Raul Pena on 16/09/23.
//

import Combine
import UIKit

final class InAppCoordinator: StateCoordinator, ChildControllerManagable {
    var childCoordinators: [NavCoordinator] = [NavCoordinator]()

    weak var parentCoordinator: ApplicationCoordinator?

    let rootViewController = MainTabBarController()
    
    
    // MARK: - start
    func start() {
//        let tabBarVC = MainTabBarController()
        setUpTabBarChildCoordinators(vc: rootViewController)
        
//        rootViewController.addChild(tabBarVC)
//        let mainView = tabBarVC.view!
//        mainView.fillSuperview()
    }

    func startChildTabCoordinator(with tab: TabBar) {
        var childCoordinator: ChildTabCoordinator!
        switch tab {
        case .home:
            childCoordinator = HomeTabCoordinator()
        case .add:
            childCoordinator = RecordVideoTabCoordinator()
        case .favorites:
            childCoordinator = HomeTabCoordinator()
        case .profile:
            childCoordinator = HomeTabCoordinator()
        }

        childCoordinator.start()
        childCoordinator.parentCoordinator = self
        childCoordinators.append(childCoordinator)
    }

    // MARK: - setup
    private func setUpTabBarChildCoordinators(vc: UITabBarController) {
        var tabBarVCs = [UINavigationController]()
        TabBar.allCases.forEach { tab in
            startChildTabCoordinator(with: tab)
            let tabBarVC = childCoordinators[tab.tag].rootViewController
            setUpTabBarComponents(for: tab, with: tabBarVC)
            tabBarVCs.append(tabBarVC)
        }
        vc.viewControllers = tabBarVCs
        vc.selectedIndex = 0
    }

    private func setUpTabBarComponents(for tab: TabBar, with vc: UIViewController) {
        vc.tabBarItem = .init(title: tab.rawValue, image: UIImage(systemName: tab.imageName), selectedImage: UIImage(systemName: tab.imageName))
        vc.tabBarItem.tag = tab.tag
    }

    deinit {
        print("✅ Deinit InAppCoordinator")
    }
}

