//
//  SeriesListCoordinator.swift
//  Atomles
//
//  Created by Ildar on 25.03.2022.
//

import UIKit

class SeriesListCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let seriesListViewController = SeriesViewController()
        let seriesListPresenter = SeriesListPresenter(
            view: seriesListViewController,
            seriesService: SeriesService()
        )
        seriesListViewController.presenter = seriesListPresenter
        
        navigationController.pushViewController(seriesListViewController, animated: true)
    }
}
