//  MoodMeMoustaches

import Foundation

protocol StateCoordinator: Coordinator, ChildControllerManagable {
    var parentCoordinator: ApplicationCoordinator? { get set }
}
