//
//  CharacterDetailViewController.swift
//  Atomles
//
//  Created by Ildar on 08.03.2022.
//

import UIKit

protocol CharacterDetailViewProtocol: AnyObject {
    func setNavigationTitle(title: String)
    func setCharacterImage(image: UIImage)
    func setCharacterDescription(description: String)
    func reloadData(section: CharacterDetailSection)
}

enum CharacterDetailSection: Int, CaseIterable {
    case photo
    case description
}

class CharacterDetailViewController: UIViewController {

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
        setupNavigationItem()
        
        presenter?.viewDidLoad()
    }
    
    // MARK: - Properties
    var presenter: CharacterDetailPresenterProtocol?
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsSelection = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var characterImage: UIImage?
    private var characterDescription: String?
}

// MARK: - View Protocol
extension CharacterDetailViewController: CharacterDetailViewProtocol {
    
    func setNavigationTitle(title: String) {
        self.navigationItem.title = title
    }
    
    func setCharacterImage(image: UIImage) {
        self.characterImage = image
    }
    
    func setCharacterDescription(description: String) {
        self.characterDescription = description
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
        switch section {
        case CharacterDetailSection.photo.rawValue:
            return "Фото"
        case CharacterDetailSection.description.rawValue:
            return "Описание"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case CharacterDetailSection.photo.rawValue:
            let cell = CharacterPhotoCell()
            cell.setImage(image: characterImage)
            return cell
        case CharacterDetailSection.description.rawValue:
            let cell = CharacterDescriptionCell()
            cell.setDescriptionText(text: characterDescription)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case CharacterDetailSection.photo.rawValue:
            return 350.0
        case CharacterDetailSection.description.rawValue:
            return UITableView.automaticDimension
        default:
            return 44.0
        }
    }
}

// MARK: - UI Setup
extension CharacterDetailViewController {
    
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        self.view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupNavigationItem() {
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
}
