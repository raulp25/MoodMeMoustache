//  MoodMeMoustaches

import Foundation

protocol ChildTabCoordinator: NavCoordinator, ChildControllerManagable {
    var parentCoordinator: InAppCoordinator? { get set }
}
