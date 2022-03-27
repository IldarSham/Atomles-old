//
//  SeriesFilterCell.swift
//  Atomles
//
//  Created by Ildar on 25.03.2022.
//

import UIKit

class SeriesFilterCell: UICollectionViewCell {
    
    static let reuseId = "seriesFilterCell"
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    private let seriesFilterButton: UIView = {
        let button = UIView()
        button.layer.borderColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        button.layer.borderWidth = 1.5
        button.layer.cornerRadius = 14
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let seriesFilterTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: Dimensions.seriesFilterFontSize)
        label.textColor = #colorLiteral(red: 0.1699999571, green: 0.1699999571, blue: 0.1699999571, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func configure(with title: String) {
        seriesFilterTitleLabel.text = title
    }
    
    func select() {
        seriesFilterButton.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        seriesFilterTitleLabel.textColor = .white
    }
    
    func deselect() {
        seriesFilterButton.backgroundColor = .none
        seriesFilterTitleLabel.textColor = #colorLiteral(red: 0.1699999571, green: 0.1699999571, blue: 0.1699999571, alpha: 1)
    }
}

// MARK: UI Setup
extension SeriesFilterCell {
    
    private func setupUI() {
        self.contentView.addSubview(seriesFilterButton)
        
        seriesFilterButton.addSubview(seriesFilterTitleLabel)
        
        NSLayoutConstraint.activate([
            seriesFilterButton.widthAnchor.constraint(equalTo: self.contentView.widthAnchor),
            seriesFilterButton.heightAnchor.constraint(equalTo: self.contentView.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            seriesFilterTitleLabel.centerXAnchor.constraint(equalTo: seriesFilterButton.centerXAnchor),
            seriesFilterTitleLabel.centerYAnchor.constraint(equalTo: seriesFilterButton.centerYAnchor)
        ])
    }
}
