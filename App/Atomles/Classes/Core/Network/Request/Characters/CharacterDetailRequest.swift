//
//  CharacterDetailRequest.swift
//  Atomles
//
//  Created by Ildar on 09.03.2022.
//

import Foundation

struct CharacterDetailRequest: DataRequest {
    
    typealias Response = CharacterDetailResponse
    
    let id: String
    
    var url: String {
        Constants.baseURL + "characters/detail"
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var queryItems: [String: String] {
        [
            "id": id
        ]
    }
}
