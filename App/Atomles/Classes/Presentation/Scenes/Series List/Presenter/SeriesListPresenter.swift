//
//  SeriesListPresenter.swift
//  Atomles
//
//  Created by Ildar on 25.03.2022.
//

import Foundation

protocol SeriesListPresenterProtocol {
    func viewDidLoad()
    func seriesForRowAt(indexPath: IndexPath) -> SeriesResponse?
    func numberOfSections() -> Int?
    func retreiveLink(indexPath: IndexPath) -> String?
    func didSelectSeriesFilter(filter: SeriesFilter)
}

class SeriesListPresenter {
    
    // MARK: - Properties
    weak var view: SeriesListViewProtocol!
    private let seriesService: SeriesServiceProtocol
    
    private var allSeries: [SeriesResponse]?
    private var series: [SeriesResponse]?
    
    // MARK: - Initialization
    init(view: SeriesListViewProtocol, seriesService: SeriesServiceProtocol) {
        self.view = view
        self.seriesService = seriesService
    }
    
    // MARK: - Methods
    private func loadAllSeries() {
        seriesService.getAllSeries { [weak self] (series, error) in
            if let series = series {
                self?.allSeries = series
                self?.series = series
                self?.view.reloadData()
            }
        }
    }
}

// MARK: - Presenter Protocol
extension SeriesListPresenter: SeriesListPresenterProtocol {
    
    func viewDidLoad() {
        loadAllSeries()
    }
    
    func seriesForRowAt(indexPath: IndexPath) -> SeriesResponse? {
        guard let series = series?[indexPath.section] else {
            return nil
        }

        return series
    }
    
    func numberOfSections() -> Int? {
        return series?.count
    }
    
    func retreiveLink(indexPath: IndexPath) -> String? {
        guard let series = series?[indexPath.section] else {
            return nil
        }

        return series.link
    }
    
    func didSelectSeriesFilter(filter: SeriesFilter) {
        guard let allSeries = allSeries else { return }
        
        switch filter {
        case .all:
            series = allSeries
        case .season1:
            series = allSeries.filter { $0.season == 1 }
        case .season2:
            series = allSeries.filter { $0.season == 2 }
        }
        
        view.reloadData()
    }
}
