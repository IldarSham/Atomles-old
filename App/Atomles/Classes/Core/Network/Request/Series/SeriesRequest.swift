//
//  SeriesRequest.swift
//  Atomles
//
//  Created by Ildar on 26.03.2022.
//

import Foundation

struct SeriesRequest: DataRequest {
    
    typealias Response = [SeriesResponse]
    
    var url: String {
        Constants.baseURL + "series"
    }
    
    var method: HTTPMethod {
        .get
    }
}
