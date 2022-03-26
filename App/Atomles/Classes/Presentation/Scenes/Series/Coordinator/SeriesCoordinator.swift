//
//  SeriesCoordinator.swift
//  Atomles
//
//  Created by Ildar on 25.03.2022.
//

import UIKit

class SeriesCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let seriesViewController = SeriesViewController()
        let seriesPresenter = SeriesPresenter(
            view: seriesViewController,
            seriesService: SeriesService()
        )
        seriesViewController.presenter = seriesPresenter
        
        navigationController.pushViewController(seriesViewController, animated: true)
    }
}
