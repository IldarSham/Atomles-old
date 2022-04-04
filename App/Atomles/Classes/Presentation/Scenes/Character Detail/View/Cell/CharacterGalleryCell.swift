//
//  CharacterGalleryCell.swift
//  Atomles
//
//  Created by Ildar on 23.03.2022.
//

import UIKit

class CharacterGalleryCell: UITableViewCell {

    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    private lazy var galleryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = Dimensions.characterGalleryMinimumLineSpacing
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CharacterPhotoCell.self, forCellWithReuseIdentifier: CharacterPhotoCell.reuseIdentifier)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: Dimensions.characterGalleryInset, bottom: 0, right: Dimensions.characterGalleryInset)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private var imagesUrls: [String]?
    
    func configure(with imagesUrls: [String]?) {
        self.imagesUrls = imagesUrls
    }
}

// MARK: - UICollectionView Delegate & Data Source
extension CharacterGalleryCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesUrls?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterPhotoCell.reuseIdentifier, for: indexPath) as! CharacterPhotoCell
 
        guard let url = imagesUrls?[indexPath.row] else { return UICollectionViewCell()}
        cell.configure(with: url)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Dimensions.characterGalleryItemWidth, height: galleryCollectionView.frame.height)
    }
}

// MARK: - UI Setup
extension CharacterGalleryCell {
    
    private func setupUI() {
        self.contentView.addSubview(galleryCollectionView)
        
        NSLayoutConstraint.activate([
            galleryCollectionView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            galleryCollectionView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            galleryCollectionView.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
            galleryCollectionView.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor)
        ])
    }
}
