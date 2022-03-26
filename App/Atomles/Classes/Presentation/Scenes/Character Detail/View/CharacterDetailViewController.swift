//
//  CharacterDetailViewController.swift
//  Atomles
//
//  Created by Ildar on 08.03.2022.
//

import UIKit

protocol CharacterDetailViewProtocol: AnyObject {
    func setNavigationTitle(title: String)
    func setCharacterGallery(imagesUrls: [String])
    func setCharacterDescription(description: String)
}

enum CharacterDetailSection: Int, CaseIterable {
    case gallery
    case description
}

class CharacterDetailViewController: UIViewController {

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
        setupNavigationItem()
        
        presenter?.viewDidLoad()
    }
    
    // MARK: - Properties
    var presenter: CharacterDetailPresenterProtocol?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsSelection = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var characterImagesUrls: [String]?
    private var characterDescription: String?
}

// MARK: - View Protocol
extension CharacterDetailViewController: CharacterDetailViewProtocol {
    
    func setNavigationTitle(title: String) {
        self.navigationItem.title = title
    }
    
    func setCharacterGallery(imagesUrls: [String]) {
        self.characterImagesUrls = imagesUrls
        self.reloadData(section: .gallery)
    }
    
    func setCharacterDescription(description: String) {
        self.characterDescription = description
        self.reloadData(section: .description)
    }
    
    func reloadData(section: CharacterDetailSection) {
        self.tableView.reloadSections([section.rawValue], with: .automatic)
    }
}

// MARK: - UITableView Delegate & Data Source
extension CharacterDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return CharacterDetailSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = CharacterDetailSection(rawValue: section) else { return nil }
        
        switch section {
        case .gallery:     return "Галерея"
        case .description: return "Описание"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = CharacterDetailSection(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch section {
        case .gallery:
            let cell = CharacterGalleryCell()
            cell.configure(with: characterImagesUrls)
            return cell
        case .description:
            let cell = CharacterDescriptionCell()
            cell.configure(with: characterDescription)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = CharacterDetailSection(rawValue: indexPath.section) else { return 44.0 }
        
        switch section {
        case .gallery:
            return Dimensions.characterGalleryCellHeight
        case .description:
            return UITableView.automaticDimension
        }
    }
}

// MARK: - UI Setup
extension CharacterDetailViewController {
    
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            tableView.heightAnchor.constraint(equalTo: self.view.heightAnchor)
        ])
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupNavigationItem() {
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
}
