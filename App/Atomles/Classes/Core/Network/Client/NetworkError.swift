//
//  NetworkError.swift
//  Atomles
//
//  Created by Ildar on 24.02.2022.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case decodingFailed
    case unknown
}
