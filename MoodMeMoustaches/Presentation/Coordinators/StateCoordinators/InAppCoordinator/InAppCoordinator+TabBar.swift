//
//  InAppCoordinator+TabBar.swift
//  pethug
//
//  Created by Raul Pena on 16/09/23.
//

import Foundation

extension InAppCoordinator {
    enum TabBar: String, CaseIterable {
        case home = "Home"
        case add = "Post"
        case favorites = "Favourites"
        case profile = "General"

        var imageName: String {
            switch self {
            case .home:
                return "house.fill"
            case .add:
                return "timelapse"
            case .favorites:
                return "heart"
            case .profile:
                return "fireplace"
            }
        }

        var tag: Int {
            switch self {
            case .home:
                return 0
            case .add:
                return 1
            case .favorites:
                return 2
            case .profile:
                return 3
            }
        }
    }
}
