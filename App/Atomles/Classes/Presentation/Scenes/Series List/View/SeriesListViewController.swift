//
//  SeriesViewController.swift
//  Atomles
//
//  Created by Ildar on 25.03.2022.
//

import UIKit

protocol SeriesListViewProtocol: AnyObject {
    func reloadData()
}

class SeriesViewController: UIViewController {

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
        setupNavigationItem()
        
        presenter?.viewDidLoad()
    }
    
    // MARK: - Properties
    var presenter: SeriesListPresenterProtocol?
    
    private lazy var seriesFiltersView: FiltersView = {
        let view = FiltersView(titles: ["Все серии", "1 сезон", "2 сезон"])
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var seriesListTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(EpisodeCell.self, forCellReuseIdentifier: EpisodeCell.reuseIdentifier)
        tableView.tableHeaderView = .init(frame: .init(x: 0, y: 0, width: 0, height: 10))
        tableView.tableFooterView = .init(frame: .init(x: 0, y: 0, width: 0, height: CGFloat.leastNonzeroMagnitude))
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 10
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
}

// MARK: - View Protocol
extension SeriesViewController: SeriesListViewProtocol {
    
    func reloadData() {
        seriesListTableView.reloadData()
    }
}

// MARK: - FiltersView Delegate
extension SeriesViewController: FiltersViewDelegate {
    
    func didSelectFilter(index: Int) {
        guard let seriesFilter = SeriesFilter(rawValue: index) else { return }
        presenter?.didSelectSeriesFilter(filter: seriesFilter)
    }
}

// MARK: - UITableView Delegate & Data Source
extension SeriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.numberOfSections() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeCell.reuseIdentifier, for: indexPath) as! EpisodeCell
        
        guard let series = presenter?.seriesForRowAt(indexPath: indexPath) else { return cell }
        cell.configure(with: series)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ac = UIAlertController(title: "Подтверждение", message: "Вы действительно хотите перейти к просмотру данной серии?", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Да", style: .default, handler: { _ in
            tableView.deselectRow(at: indexPath, animated: true)
            
            guard let link = self.presenter?.retreiveLink(indexPath: indexPath),
                let url = URL(string: link) else { return }
            
            UIApplication.shared.open(url)
        })
        
        let cancelAction = UIAlertAction(title: "Нет", style: .destructive, handler: { _ in
            tableView.deselectRow(at: indexPath, animated: true)
        })
        
        ac.addAction(okAction)
        ac.addAction(cancelAction)
        
        self.present(ac, animated: true, completion: nil)
    }
}

// MARK: - UI Setup
extension SeriesViewController {
    
    private func setupUI() {
        self.view.backgroundColor = .systemBackground
        
        self.view.addSubview(seriesFiltersView)
        self.view.addSubview(seriesListTableView)
        
        NSLayoutConstraint.activate([
            seriesFiltersView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            seriesFiltersView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            seriesFiltersView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            seriesFiltersView.heightAnchor.constraint(equalToConstant: Dimensions.seriesFiltersHeight)
        ])

        NSLayoutConstraint.activate([
            seriesListTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            seriesListTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            seriesListTableView.topAnchor.constraint(equalTo: seriesFiltersView.bottomAnchor, constant: 10),
            seriesListTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupNavigationItem() {
        self.navigationItem.title = "Серии"
    }
}
