//
//  CharacterDetailCoordinator.swift
//  Atomles
//
//  Created by Ildar on 08.03.2022.
//

import UIKit

class CharacterDetailCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    let characterId: String
    
    init(navigationController: UINavigationController,
         characterId: String) {
        self.navigationController = navigationController
        self.characterId = characterId
    }
    
    func start() {
        let viewController = CharacterDetailViewController()
        let presenter = CharacterDetailPresenter(
            view: viewController,
            charactersService: CharactersService(),
            characterId: characterId
        )
        viewController.presenter = presenter
        
        navigationController.pushViewController(viewController, animated: true)
    }
}
