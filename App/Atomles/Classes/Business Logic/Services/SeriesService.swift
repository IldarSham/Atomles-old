//
//  SeriesService.swift
//  Atomles
//
//  Created by Ildar on 26.03.2022.
//

import Foundation

protocol SeriesServiceProtocol {
    func getAllSeries(completion: @escaping ([SeriesResponse]?, Error?) -> Void)
}

class SeriesService: SeriesServiceProtocol {

    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func getAllSeries(completion: @escaping ([SeriesResponse]?, Error?) -> Void) {
        let request = SeriesRequest()
        
        networkService.performRequest(request) { result in
            switch result {
            case .success(let series):
                completion(series, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
