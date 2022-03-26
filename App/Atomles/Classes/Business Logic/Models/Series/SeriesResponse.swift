//
//  SeriesResponse.swift
//  Atomles
//
//  Created by Ildar on 26.03.2022.
//

import Foundation

struct SeriesResponse: Decodable {
    var season: Int
    var episode: Int
    var previewImageUrl: String
    var title: String
    var description: String
    var link: String
}
