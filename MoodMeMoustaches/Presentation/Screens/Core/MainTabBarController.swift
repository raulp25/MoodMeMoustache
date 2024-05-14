//
//  MainTabBarController.swift
//  rs5
//
//  Created by Raul Pena on 22/04/24.
//

import UIKit

final class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
//        setupUI()
    }
    
    private func setupTabBar() {
        tabBar.tintColor = .white
        tabBar.backgroundColor = .black
        tabBar.barTintColor = .black
        tabBar.clipsToBounds = true
    }
    
    private func setupUI() {
        let vc1 = wrapInNavigationController(vc: HomeViewController())
        vc1.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        
        let vc2 = MockVC()
        vc2.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        
        let vc3 = MockVC()
        vc3.tabBarItem = UITabBarItem(title: "Products", image: UIImage(systemName: "triangle"), tag: 2)
        
        let vc4 = MockVC()
        vc4.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 3)
        
        viewControllers = [vc1, vc2, vc3, vc4]
    }
    
    private func wrapInNavigationController(vc: UIViewController) -> UINavigationController {
        return UINavigationController(rootViewController: vc)
    }
}

final class MockVC: UIViewController {
    private let textLabel: UILabel = {
       let label = UILabel()
        label.text = "MockVC"
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textColor = .label
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        view.addSubview(textLabel)
        
        textLabel.center(inView: view)
    }
}
