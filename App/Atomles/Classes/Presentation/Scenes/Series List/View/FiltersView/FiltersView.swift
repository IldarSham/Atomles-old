//
//  FiltersView.swift
//  RxAtomles
//
//  Created by Ildar on 04.04.2022.
//

import UIKit

protocol FiltersViewDelegate: AnyObject {
    func didSelectFilter(index: Int)
}

class FiltersView: UIView {

    // MARK: - Initialization
    init(titles: [String]) {
        self.titles = titles
        super.init(frame: .zero)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    weak var delegate: FiltersViewDelegate?
    
    var titles: [String] {
        didSet {
            self.selectedIndex = 0
            self.collectionView.reloadData()
        }
    }
    
    var selectedIndex: Int = 0
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        collectionView.register(FiltersCell.self, forCellWithReuseIdentifier: FiltersCell.reuseIdentifier)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        collectionView.alwaysBounceHorizontal = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
}

// MARK: - UICollectionView Delegate & Data Source
extension FiltersView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FiltersCell.reuseIdentifier, for: indexPath) as! FiltersCell
        
        cell.titleLabel.text = titles[indexPath.item]
        if indexPath.item == selectedIndex {
            cell.select()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard indexPath.item != selectedIndex else { return }
            
        let selectedCell = collectionView.cellForItem(at: IndexPath(item: selectedIndex, section: 0)) as! FiltersCell
        selectedCell.deselect()
        
        let deselectedCell = collectionView.cellForItem(at: indexPath) as! FiltersCell
        deselectedCell.select()
        
        selectedIndex = indexPath.item
        
        delegate?.didSelectFilter(index: selectedIndex)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: collectionView.frame.height)
    }
}

// MARK: - UI Setup
extension FiltersView {
    func setupUI() {
        self.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.widthAnchor.constraint(equalTo: self.widthAnchor),
            collectionView.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
    }
    
    private func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }
}
