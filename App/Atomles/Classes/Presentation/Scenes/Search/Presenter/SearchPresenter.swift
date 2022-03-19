//
//  SearchPresenter.swift
//  Atomles
//
//  Created by Ildar on 10.02.2022.
//

import Foundation

protocol SearchPresenterProtocol {
    var isSearching: Bool { get }
    func viewDidLoad()
    func searchCharacters(name: String)
    func characterForCell(indexPath: IndexPath) -> String?
    func numberOfRowsInSection() -> Int?
    func didSelectRowAt(indexPath: IndexPath)
}

class SearchPresenter {
    
    // MARK: - Properties
    weak var view: SearchViewProtocol?
    
    private let coordinator: SearchCoordinator
    
    private let charactersService: CharactersServiceProtocol
    
    private var mainCharactersItems: [CharactersInfoResponse]?
    private var foundCharactersItems: [CharactersInfoResponse]?
    private var characters: [CharactersInfoResponse]? {
        return isSearching ? foundCharactersItems : mainCharactersItems
    }
    
    // MARK: - Initialization
    init(view: SearchViewProtocol, charactersService: CharactersServiceProtocol, coordinator: SearchCoordinator) {
        self.view = view
        self.charactersService = charactersService
        self.coordinator = coordinator
    }
    
    // MARK: - Methods
    func loadMainCharacters() {
        charactersService.getMainCharacters { [weak self] (characters, error) in
            if let characters = characters {
                self?.mainCharactersItems = characters
                self?.view?.reloadData()
            }
        }
    }
}

// MARK: - Presenter Protocol
extension SearchPresenter: SearchPresenterProtocol {
    
    var isSearching: Bool {
        return view?.isSearching() ?? false
    }
    
    func viewDidLoad() {
        loadMainCharacters()
    }
    
    func searchCharacters(name: String) {
        charactersService.searchCharacters(name: name) { [weak self] (characters, error) in
            if let characters = characters {
                self?.foundCharactersItems = characters
                self?.view?.reloadData()
            }
        }
    }
    
    func characterForCell(indexPath: IndexPath) -> String? {
        return characters?[indexPath.row].name
    }
    
    func numberOfRowsInSection() -> Int? {
        return characters?.count
    }
    
    func didSelectRowAt(indexPath: IndexPath) {
        guard let characterId = characters?[indexPath.row].id else {
            return
        }
        
        coordinator.coordinateToDetail(with: String(characterId))
    }
}
