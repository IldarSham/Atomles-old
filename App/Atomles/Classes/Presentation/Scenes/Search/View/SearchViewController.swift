//
//  SearchViewController.swift
//  Atomles
//
//  Created by Ildar on 03.02.2022.
//

import UIKit

protocol SearchViewProtocol: AnyObject {
    func isSearching() -> Bool
    func reloadData()
}

class SearchViewController: UIViewController {

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
        setupNavigationItem()
        
        presenter?.viewDidLoad()
    }
    
    // MARK: - Properties
    var presenter: SearchPresenterProtocol?
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Персонажи"
        return searchController
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "characterCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var typeDelayTimer: Timer?
    private let typingDelay = 0.2
}

// MARK: - View Protocol
extension SearchViewController: SearchViewProtocol {
    
    func isSearching() -> Bool {
        var searchBarIsEmpty: Bool {
            guard let text = searchController.searchBar.text else { return false }
            return text.isEmpty
        }
        
        return searchController.isActive && !searchBarIsEmpty
    }
    
    func reloadData() {
        self.tableView.reloadData()
    }
}

// MARK: - UISearchBar Delegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        typeDelayTimer?.invalidate()
        typeDelayTimer = Timer.scheduledTimer(withTimeInterval: typingDelay, repeats: false, block: {  [unowned self] _ in
            presenter?.searchCharacters(name: searchText)
        })
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        self.reloadData()
    }
}

// MARK: - UITableView Delegate & Data Source
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRowAt(indexPath: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath)
        
        var configuration = cell.defaultContentConfiguration()
        configuration.text = presenter?.characterForCell(indexPath: indexPath)
        
        cell.contentConfiguration = configuration
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let isSearching = presenter?.isSearching, !isSearching else { return nil }
        
        let header = SearchHeaderView()
        header.titleLabel.text = "Основные"
        
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let isSearching = presenter?.isSearching, !isSearching else { return 0.0 }
        return 44.0
    }
}

// MARK: - UI Setup
extension SearchViewController {
    
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
        self.navigationItem.title = "Поиск"
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
    }
}
