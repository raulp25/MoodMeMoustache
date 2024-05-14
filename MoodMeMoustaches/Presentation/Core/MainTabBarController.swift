//  MoodMeMoustaches

import UIKit

final class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        tabBar.tintColor = .white
        tabBar.backgroundColor = .black
        tabBar.barTintColor = .black
        tabBar.clipsToBounds = true
    }
}


