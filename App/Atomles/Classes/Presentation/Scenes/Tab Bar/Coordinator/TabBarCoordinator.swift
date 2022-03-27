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
        
        let seriesNavigationController = UINavigationController()
        seriesNavigationController.tabBarItem = UITabBarItem(
            title: "Серии", image: UIImage(systemName: "play.circle"), tag: 1)
        let seriesListCoordinator = SeriesListCoordinator(navigationController: seriesNavigationController)
        
        let searchNavigationController = UINavigationController()
        searchNavigationController.tabBarItem = UITabBarItem(
            title: "Поиск", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        let searchCoordinator = SearchCoordinator(navigationController: searchNavigationController)
        
        tabBarController.viewControllers = [seriesNavigationController, searchNavigationController]
        
        navigationController.viewControllers = [tabBarController]
        
        coordinate(to: seriesListCoordinator)
        coordinate(to: searchCoordinator)
    }
}
