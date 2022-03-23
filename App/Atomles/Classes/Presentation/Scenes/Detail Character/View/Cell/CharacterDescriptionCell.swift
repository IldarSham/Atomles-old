//
//  CharacterDescriptionCell.swift
//  Atomles
//
//  Created by Ildar on 12.03.2022.
//

import Foundation
import UIKit

class CharacterDescriptionCell: UITableViewCell {

    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    let characterDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func configure(with text: String?) {
        characterDescriptionLabel.text = text
    }
}

// MARK: - UI Setup
extension CharacterDescriptionCell {
    
    private func setupUI() {
        self.contentView.addSubview(characterDescriptionLabel)
    
        NSLayoutConstraint.activate([
            characterDescriptionLabel.leftAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leftAnchor),
            characterDescriptionLabel.rightAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.rightAnchor),
            characterDescriptionLabel.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
            characterDescriptionLabel.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor)
        ])
    }
}
