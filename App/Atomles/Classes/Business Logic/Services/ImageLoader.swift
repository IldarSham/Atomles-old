//
//  ImageLoader.swift
//  Atomles
//
//  Created by Ildar on 12.03.2022.
//

import UIKit

protocol ImageLoaderProtocol {
    func loadImageFrom(urlString: String, completion: @escaping (UIImage?) -> Void)
}

class ImageLoader: ImageLoaderProtocol {
    
    let core: ImageLoaderCoreProtocol
    
    init(core: ImageLoaderCoreProtocol = ImageLoaderCore()) {
        self.core = core
    }
    
    func loadImageFrom(urlString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        core.getImageData(from: url) { (data) in
            if let data = data {
                completion(UIImage(data: data))
            } else {
                completion(nil)
            }
        }
    }
}
