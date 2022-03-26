//
//  SeriesViewController.swift
//  Atomles
//
//  Created by Ildar on 25.03.2022.
//

import UIKit

protocol SeriesViewProtocol: AnyObject {
    func reloadData()
}

enum SeriesFilter: Int, CaseIterable {
    case all
    case season1
    case season2
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
    var presenter: SeriesPresenterProtocol?
        
    private var seriesFilter: SeriesFilter = .all
    
    private lazy var seriesFilterCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SeriesFilterCell.self, forCellWithReuseIdentifier: SeriesFilterCell.reuseId)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: Dimensions.seriesFilterInset, bottom: 0, right: Dimensions.seriesFilterInset)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceHorizontal = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private lazy var seriesListTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(EpisodeCell.self, forCellReuseIdentifier: EpisodeCell.reuseId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Methods
    func setSeriesFilter(filter: SeriesFilter) {
        seriesFilter = filter
        presenter?.setSeriesFilter(filter: filter)
    }
}

// MARK: - View Protocol
extension SeriesViewController: SeriesViewProtocol {
    
    func reloadData() {
        seriesListTableView.reloadData()
    }
}

// MARK: - UICollectionView Delegate & Data Source
extension SeriesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return SeriesFilter.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SeriesFilterCell.reuseId, for: indexPath) as! SeriesFilterCell
        
        guard let filter = SeriesFilter(rawValue: indexPath.item) else { return cell }
        
        switch filter {
        case .all:     cell.configure(with: "Все серии")
        case .season1: cell.configure(with: "1 сезон")
        case .season2: cell.configure(with: "2 сезон")
        }
        
        if filter == seriesFilter {
            cell.select()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Dimensions.seriesFilterItemWidth, height: seriesFilterCollectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let filter = SeriesFilter(rawValue: indexPath.item), filter != seriesFilter else { return }
        
        let selectedCell = collectionView.cellForItem(at: IndexPath(item: seriesFilter.rawValue, section: indexPath.section)) as! SeriesFilterCell
        selectedCell.deselect()
        
        let deselectedCell = collectionView.cellForItem(at: indexPath) as! SeriesFilterCell
        deselectedCell.select()
        
        setSeriesFilter(filter: filter)
    }
}

// MARK: - UITableView Delegate & Data Source
extension SeriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeCell.reuseId, for: indexPath) as! EpisodeCell
        
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
        
        self.view.addSubview(seriesFilterCollectionView)
        self.view.addSubview(seriesListTableView)
        
        NSLayoutConstraint.activate([
            seriesFilterCollectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            seriesFilterCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            seriesFilterCollectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            seriesFilterCollectionView.heightAnchor.constraint(equalToConstant: 28)
        ])
        
        NSLayoutConstraint.activate([
            seriesListTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            seriesListTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            seriesListTableView.topAnchor.constraint(equalTo: seriesFilterCollectionView.bottomAnchor, constant: 10),
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
