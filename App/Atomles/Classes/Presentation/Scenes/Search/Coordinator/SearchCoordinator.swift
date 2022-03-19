//
//  StartCoordinator.swift
//  Atomles
//
//  Created by Ildar on 03.02.2022.
//

import UIKit

protocol SearchFlow {
    func coordinateToDetail(with characterId: String)
}

class SearchCoordinator: Coordinator, SearchFlow {
    
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let searchViewController = SearchViewController()
        let searchPresenter = SearchPresenter(
            view: searchViewController,
            charactersService: CharactersService(),
            coordinator: self
        )
        searchViewController.presenter = searchPresenter
        
        navigationController.pushViewController(searchViewController, animated: true)
    }
    
    // MARK: - Flow Methods
    func coordinateToDetail(with characterId: String) {
        let detailCharacterCoordinator = CharacterDetailCoordinator(
            navigationController: navigationController,
            characterId: characterId
        )
        
        coordinate(to: detailCharacterCoordinator)
    }
}
