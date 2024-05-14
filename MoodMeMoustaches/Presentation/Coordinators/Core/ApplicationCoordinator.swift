//  MoodMeMoustaches

import Combine
import UIKit

final class ApplicationCoordinator: Coordinator {
    
    var rootViewController: UINavigationController = .init()
    
    var childCoordinators: [StateCoordinator] = [StateCoordinator]()
    
    private let window: UIWindow
    
    //MARK: - init
    init(window: UIWindow) {
        self.window = window
    }
    
    //MARK: - Setup / listen
    func start() {
        setUpCoordinator()
    }
    
    //MARK: - Private methods
    private func setUpCoordinator() {
        var childCoordinator: StateCoordinator?
        let coordinator = InAppCoordinator()
        window.rootViewController = coordinator.rootViewController
        childCoordinator = coordinator
        
        
        guard let childCoordinator else { return }
        childCoordinator.parentCoordinator = self
        childCoordinator.start()
        childCoordinators.removeAll()
        childCoordinators.append(childCoordinator)
    }
    
    
}
