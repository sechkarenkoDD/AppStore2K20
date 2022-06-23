//
//  MainTabBarController.swift
//  AppStore2K16
//
//  Created by Дмитрий Сечкаренко on 31.05.2022.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            addCreateNavigationController(
                viewController: TodayViewController(),
                withTitle: "Today",
                andImageTabBar: "doc.text.image"),
            
            addCreateNavigationController(
                viewController: AppsViewController(),
                withTitle: "Apps",
                andImageTabBar: "square.stack.3d.up.fill"),
            
            addCreateNavigationController(
                viewController: SearchViewController(),
                withTitle: "Search",
                andImageTabBar: "magnifyingglass")
        ]
    }
    
    private func addCreateNavigationController(viewController: UIViewController, withTitle title: String, andImageTabBar image: String) -> UIViewController {
        
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.prefersLargeTitles = true
        
        viewController.navigationItem.title = title
        viewController.view.backgroundColor = .white
        
        setupTabBarItem(navigationController, title, image)
        
        return navigationController
    }
    
    private func setupTabBarItem(_ navigationView: UINavigationController, _ title: String, _ image: String) {
        navigationView.tabBarItem.title = title
        navigationView.tabBarItem.image = UIImage(systemName: image)
    }
}
