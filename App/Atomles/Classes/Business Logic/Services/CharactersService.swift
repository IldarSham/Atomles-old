//
//  CharactersService.swift
//  Atomles
//
//  Created by Ildar on 24.02.2022.
//

import Foundation

protocol CharactersServiceProtocol {
    func getMainCharacters(completion: @escaping ([CharactersInfoResponse]?, Error?) -> Void)
    func searchCharacters(name: String, completion: @escaping ([CharactersInfoResponse]?, Error?) -> Void)
    func getCharacterDetail(id: String, completion: @escaping (CharacterDetailResponse?, Error?) -> Void)
}

class CharactersService: CharactersServiceProtocol {
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func getMainCharacters(completion: @escaping ([CharactersInfoResponse]?, Error?) -> Void) {
        let request = MainCharactersRequest()
        
        networkService.performRequest(request) { result in
            switch result {
            case .success(let characters):
                completion(characters, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func searchCharacters(name: String, completion: @escaping ([CharactersInfoResponse]?, Error?) -> Void) {
        let request = SearchCharactersRequest(name: name)

        networkService.performRequest(request) { result in
            switch result {
            case .success(let characters):
                completion(characters, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    func getCharacterDetail(id: String, completion: @escaping (CharacterDetailResponse?, Error?) -> Void) {
        let request = CharacterDetailRequest(id: id)

        networkService.performRequest(request) { result in
            switch result {
            case .success(let character):
                completion(character, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
