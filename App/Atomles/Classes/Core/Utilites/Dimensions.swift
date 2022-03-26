//
//  Dimensions.swift
//  Atomles
//
//  Created by Ildar on 23.03.2022.
//

import UIKit

struct Dimensions {
    
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height
    
    static let characterGalleryCellHeight = 400.0
    static let characterGalleryMinimumLineSpacing = 10.0
    static let characterGalleryInset = 20.0
    static let characterGalleryItemWidth = screenWidth - characterGalleryInset * 2
    
    static let seriesFilterFontSize = 11.0
    static let seriesFilterInset = 20.0
    static let seriesFilterItemWidth = 90.0
}
