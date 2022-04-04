//
//  FiltersCell.swift
//  RxAtomles
//
//  Created by Ildar on 04.04.2022.
//

import UIKit

class FiltersCell: UICollectionViewCell {
    
    static let reuseIdentifier = "filterCell"
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    lazy var roundedBackgroundView: UIView = {
        let button = UIView()
        button.layer.borderColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        button.layer.borderWidth = 1.5
        button.layer.cornerRadius = self.contentView.frame.height / 2
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = #colorLiteral(red: 0.1699999571, green: 0.1699999571, blue: 0.1699999571, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Methods
    func select() {
        roundedBackgroundView.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        titleLabel.textColor = .white
    }
    
    func deselect() {
        roundedBackgroundView.backgroundColor = .none
        titleLabel.textColor = #colorLiteral(red: 0.1699999571, green: 0.1699999571, blue: 0.1699999571, alpha: 1)
    }
}

// MARK: - UI Setup
extension FiltersCell {
    private func setupUI() {
        self.contentView.addSubview(roundedBackgroundView)
        roundedBackgroundView.addSubview(titleLabel)
        
        roundedBackgroundView.widthAnchor
            .constraint(equalTo: self.contentView.widthAnchor)
            .isActive = true
        
        roundedBackgroundView.heightAnchor
            .constraint(equalTo: self.contentView.heightAnchor)
            .isActive = true
        
        titleLabel.centerXAnchor
            .constraint(equalTo: roundedBackgroundView.centerXAnchor)
            .isActive = true
        
        titleLabel.centerYAnchor
            .constraint(equalTo: roundedBackgroundView.centerYAnchor)
            .isActive = true
    }
}
