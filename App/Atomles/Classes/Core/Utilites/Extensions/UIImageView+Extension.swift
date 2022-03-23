//
//  UIImageView+Extension.swift
//  Atomles
//
//  Created by Ildar on 23.03.2022.
//

import UIKit

class ImageCache {
    
    private static let imageCache = NSCache<NSString, UIImage>()
    
    static subscript(_ key: String) -> UIImage? {
        return imageCache.object(forKey: key as NSString)
    }
    
    static func set(_ key: String, _ image: UIImage) {
        imageCache.setObject(image, forKey: key as NSString)
    }
}

extension UIImageView {
    
    func setImage(with urlString: String) {
        if let cachedImage = ImageCache[urlString] {
            self.image = cachedImage
            return
        }

        guard let url = URL(string: urlString) else { return }
        
        DispatchQueue.global(qos: .utility).async {
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                guard let data = data, let image = UIImage(data: data) else { return }
                ImageCache.set(urlString, image)
                self.image = image
            }
        }
    }
}
