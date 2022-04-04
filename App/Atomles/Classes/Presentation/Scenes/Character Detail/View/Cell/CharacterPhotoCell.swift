//
//  CharacterPhotoCell.swift
//  Atomles
//
//  Created by Ildar on 09.03.2022.
//

import UIKit

class CharacterPhotoCell: UICollectionViewCell {
    
    static let reuseIdentifier = "characterPhotoCell"

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.characterImageView.image = nil
    }
    
    func configure(with url: String) {
        characterImageView.setImage(with: url)
    }
}

// MARK: - UI Setup
extension CharacterPhotoCell {
    
    private func setupUI() {
        self.contentView.addSubview(characterImageView)
    
        NSLayoutConstraint.activate([
            characterImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor),
            characterImageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor),
            characterImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            characterImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ])
    }
}
