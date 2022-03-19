//
//  NetworkService.swift
//  Atomles
//
//  Created by Ildar on 24.02.2022.
//

import Foundation

protocol NetworkServiceProtocol {
    func performRequest<Request: DataRequest>(_ request: Request, completion: @escaping (Result<Request.Response, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    
    func performRequest<Request: DataRequest>(_ request: Request, completion: @escaping (Result<Request.Response, Error>) -> Void) {
        guard var urlComponents = URLComponents(string: request.url) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var queryItems: [URLQueryItem] = []
        request.queryItems.forEach {
            queryItems.append(URLQueryItem(name: $0.key, value: $0.value))
        }
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
    
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.allHTTPHeaderFields = request.headers
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data,
                let response = response as? HTTPURLResponse, (200..<300) ~= response.statusCode else {
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.failure(NetworkError.unknown))
                    }
                    return
                }
                        
            guard let decodeData = try? request.decode(data) else {
                completion(.failure(NetworkError.decodingFailed))
                return
            }
            
            DispatchQueue.main.async {
                completion(.success(decodeData))
            }
        }.resume()
    }
}
