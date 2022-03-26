//
//  SearchCharactersRequest.swift
//  Atomles
//
//  Created by Ildar on 07.03.2022.
//

import Foundation

struct SearchCharactersRequest: DataRequest {
    
    typealias Response = [CharactersInfoResponse]
    
    let name: String
    
    var url: String {
        Constants.baseURL + "characters/search"
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var queryItems: [String: String] {
        [
            "name": name
        ]
    }
}
