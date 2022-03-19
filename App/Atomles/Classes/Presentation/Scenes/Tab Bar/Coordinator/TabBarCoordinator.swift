//
//  TabBarCoordinator.swift
//  Atomles
//
//  Created by Ildar on 07.02.2022.
//

import UIKit

class TabBarCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let tabBarController = TabBarController()
        
        let searchNavigationController = UINavigationController()
        searchNavigationController.tabBarItem = UITabBarItem(
            title: "Поиск", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        let searchCoordinator = SearchCoordinator(navigationController: searchNavigationController)
        
        tabBarController.viewControllers = [searchNavigationController]
        
        navigationController.viewControllers = [tabBarController]
        
        coordinate(to: searchCoordinator)
    }
}
