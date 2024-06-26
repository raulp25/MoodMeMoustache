//  MoodMeMoustaches

import Combine
import UIKit

final class InAppCoordinator: StateCoordinator, ChildControllerManagable {
    var childCoordinators: [NavCoordinator] = [NavCoordinator]()

    weak var parentCoordinator: ApplicationCoordinator?

    let rootViewController = MainTabBarController()
    
    // MARK: - start
    func start() {
        setUpTabBarChildCoordinators(vc: rootViewController)
    }

    func startChildTabCoordinator(with tab: TabBar) {
        var childCoordinator: ChildTabCoordinator!
        switch tab {
        case .home:
            childCoordinator = HomeTabCoordinator()
        case .add:
            childCoordinator = RecordVideoTabCoordinator()
        case .favorites:
            childCoordinator = MockTabCoordinator()
        case .profile:
            childCoordinator = MockTabCoordinator()
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
        vc.tabBarItem = .init(title: tab.rawValue, 
                              image: UIImage(systemName: tab.imageName),
                              selectedImage: UIImage(systemName: tab.imageName))
        vc.tabBarItem.tag = tab.tag
    }

    deinit {
        print("✅ Deinit InAppCoordinator")
    }
}

