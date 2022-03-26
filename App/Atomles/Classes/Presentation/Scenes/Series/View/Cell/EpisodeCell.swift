//
//  EpisodeCell.swift
//  Atomles
//
//  Created by Ildar on 26.03.2022.
//

import UIKit

class EpisodeCell: UITableViewCell {

    static let reuseId = "episodeCell"
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = Colors.seriesFilterButtonColor
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let episodeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let previewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    func configure(with series: SeriesResponse) {
        previewImageView.setImage(with: series.previewImageUrl)
        titleLabel.text = series.title
        episodeLabel.text = "\(series.season) сезон, \(series.episode) серия"
        descriptionLabel.text = series.description
    }
}

// MARK: - UI Setup
extension EpisodeCell {
    
    private func setupUI() {
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(episodeLabel)
        self.contentView.addSubview(descriptionLabel)
        self.contentView.addSubview(previewImageView)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            episodeLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            episodeLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            episodeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: episodeLabel.bottomAnchor, constant: 10),
        ])
        
        NSLayoutConstraint.activate([
            previewImageView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            previewImageView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            previewImageView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            previewImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            previewImageView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
}
