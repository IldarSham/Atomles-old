//
//  CharacterDetailPresenter.swift
//  Atomles
//
//  Created by Ildar on 08.03.2022.
//

import UIKit

protocol CharacterDetailPresenterProtocol {
    func viewDidLoad()
}

class CharacterDetailPresenter {
    
    // MARK: - Properties
    weak var view: CharacterDetailViewProtocol?
    
    private let charactersService: CharactersServiceProtocol
    private let imageLoader: ImageLoaderProtocol
    
    private let characterId: String
        
    // MARK: - Initialization
    init(view: CharacterDetailViewProtocol, charactersService: CharactersServiceProtocol, imageLoader: ImageLoaderProtocol, characterId: String) {
        self.view = view
        self.charactersService = charactersService
        self.imageLoader = imageLoader
        self.characterId = characterId
    }
    
    // MARK: - Methods
    func loadCharacterDetail(id: String) {
        charactersService.getCharacterDetail(id: id) { [weak self] (characterDetail, error) in
            if let characterDetail = characterDetail {
                self?.configureView(with: characterDetail)
            }
        }
    }
    
    func configureView(with characterDetail: CharacterDetailResponse) {
        view?.setNavigationTitle(title: characterDetail.name)
        
        view?.setCharacterDescription(description: characterDetail.description)
        view?.reloadData(section: .description)

        imageLoader.loadImageFrom(urlString: characterDetail.imageUrl) { [weak self] image in
            guard let image = image else { return }
            self?.view?.setCharacterImage(image: image)
            self?.view?.reloadData(section: .photo)
        }
    }
}

// MARK: - Presenter Protocol
extension CharacterDetailPresenter: CharacterDetailPresenterProtocol {
    
    func viewDidLoad() {
        loadCharacterDetail(id: characterId)
    }
}
