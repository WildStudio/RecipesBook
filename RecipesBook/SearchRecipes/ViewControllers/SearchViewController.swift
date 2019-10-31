//
//  SearchViewController.swift
//  RecipesBook
//
//  Created by wearemobilefirst on 31/10/2019.
//  Copyright © 2019 badi. All rights reserved.
//

import UIKit

class SearchViewController: UICollectionViewController {
    
    private enum Constant {
          static let cellReuseIdentifier = "cell"
          static let alertTitle = "Something went wrong"
          static let alertOK = "OK"
          static let searchBarPlaceholder = "Start typing to search recipes..."
          static let showDetailView = "showdetail"
          static let prefetchingCell = 5
    }

    private var search: UISearchController?
    private var viewModel: SearchViewModel
    
    // MARK: - Life cycle

    public init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
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
