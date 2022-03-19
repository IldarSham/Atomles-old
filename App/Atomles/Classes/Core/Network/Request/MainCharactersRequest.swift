//
//  MainCharactersRequest.swift
//  Atomles
//
//  Created by Ildar on 24.02.2022.
//

import Foundation

struct MainCharactersRequest: DataRequest {
    
    typealias Response = [CharactersInfoResponse]
    
    var url: String {
        Constants.baseURL + "characters/main"
    }
    
    var method: HTTPMethod {
        .get
    }
}
