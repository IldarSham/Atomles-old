//
//  CharacterPhotoCell.swift
//  Atomles
//
//  Created by Ildar on 09.03.2022.
//

import UIKit

class CharacterPhotoCell: UITableViewCell {

    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "1")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    func setImage(image: UIImage?) {
        characterImageView.image = image
    }
}

// MARK: - UI Setup
extension CharacterPhotoCell {
    
    private func setupUI() {
        self.contentView.addSubview(characterImageView)
    
        NSLayoutConstraint.activate([
            characterImageView.leftAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leftAnchor),
            characterImageView.rightAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.rightAnchor),
            characterImageView.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
            characterImageView.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor)
        ])
    }
}
