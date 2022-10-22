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
            addViewController(
                viewController: TodayController(),
                withTitle: "Today",
                andImageTabBar: "doc.text.image",
                withNavigation: true),
            
            addViewController(
                viewController: AppsPageController(),
                withTitle: "Apps",
                andImageTabBar: "square.stack.3d.up.fill"),
            
            addViewController(
                viewController: AppsSearchController(),
                withTitle: "Search",
                andImageTabBar: "magnifyingglass")
        ]
    }
    
    private func addViewController(viewController: UIViewController, withTitle title: String, andImageTabBar image: String, withNavigation navigationControllerHiden: Bool = false) -> UIViewController {
        
        if navigationControllerHiden == false {
            let navigationController = UINavigationController(rootViewController: viewController)
            navigationController.navigationBar.prefersLargeTitles = true
            viewController.navigationItem.title = title
            navigationController.tabBarItem.title = title
            navigationController.tabBarItem.image = UIImage(systemName: image)
            return navigationController
        } else {
            viewController.tabBarItem.title = title
            viewController.tabBarItem.image = UIImage(systemName: image)
            return viewController
        }
    }
    
}
