//
//  CharacterDetailResponse.swift
//  Atomles
//
//  Created by Ildar on 09.03.2022.
//

import Foundation

struct CharacterDetailResponse: Decodable {
    var id: Int
    var name: String
    var imageUrl: String
    var description: String
}
