//
//  SearchViewController.swift
//  RecipesBook
//
//  Created by wearemobilefirst on 31/10/2019.
//  Copyright © 2019 badi. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    private enum Constant {
          static let cellReuseIdentifier = "cell"
          static let alertTitle = "Something went wrong"
          static let alertOK = "OK"
          static let searchBarPlaceholder = "Start typing to search recipes..."
          static let showDetailView = "showdetail"
          static let prefetchingCell = 5
    }

    private var search: UISearchController?
    private var viewModel: SearchViewModel?
    @IBOutlet private var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet private var collectionView: UICollectionView!
    // MARK: - Life cycle

    public init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        setupCollectionView()
    }
    
    
    
    private func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        search = searchController
        search?.searchResultsUpdater = self
        search?.obscuresBackgroundDuringPresentation = false
        search?.searchBar.placeholder = Constant.searchBarPlaceholder
        navigationItem.searchController = search
        navigationItem.hidesSearchBarWhenScrolling = false
        search?.searchBar.isHidden = true
    }
    
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(RecipeCell.self, forCellWithReuseIdentifier: Constant.cellReuseIdentifier)
    }

}

// MARK: - UISearchResultsUpdating

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text
            else { return }
//        viewModel?.updateSearchResults(for: text)
        collectionView.reloadData()
    }
}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.cellReuseIdentifier, for: indexPath)
        cell.backgroundColor = UIColor.red

        return cell
    }

}


