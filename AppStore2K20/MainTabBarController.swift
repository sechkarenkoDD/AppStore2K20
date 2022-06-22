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

        let todayVC = TodayViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let todayNavigationVC = UINavigationController(rootViewController: todayVC)
        setupNavigationTabBar(todayNavigationVC, withTitle: "Today", andImage: "doc.text.image")

        
        let appsVC = AppsViewController()
        let appsNavigationVC = UINavigationController(rootViewController: appsVC)
        setupNavigationTabBar(appsNavigationVC, withTitle: "Apps", andImage: "square.stack.3d.up.fill")
        
        let searchVC = SearchViewController()
        let searchNavigationVC = UINavigationController(rootViewController: searchVC)
        setupNavigationTabBar(searchNavigationVC, withTitle: "Seatch", andImage: "magnifyingglass")
                
        viewControllers = [todayNavigationVC, appsNavigationVC, searchNavigationVC]
    }
    
    private func setupNavigationTabBar(_ navigationView: UINavigationController, withTitle title: String, andImage image: String) {
        navigationView.tabBarItem.title = title
        navigationView.tabBarItem.image = UIImage(systemName: image)
    }
}
