//
//  ImageLoaderCore.swift
//  Atomles
//
//  Created by Ildar on 12.03.2022.
//

import Foundation

protocol ImageLoaderCoreProtocol {
    func getImageData(from url: URL, completion: @escaping (_ data: Data?) -> Void)
}

class ImageLoaderCore: ImageLoaderCoreProtocol {
    func getImageData(from url: URL, completion: @escaping (_ data: Data?) -> Void) {
        DispatchQueue.global(qos: .background).async {
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                completion(data)
            }
        }
    }
}
