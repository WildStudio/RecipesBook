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
          static let prefetchingCell = 5
    }

    private var search: UISearchController?
    private var viewModel: SearchViewModel?
    @IBOutlet private var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet private var collectionView: UICollectionView!
    
    
    // MARK: - Life cycle

    func configure(with viewModel: SearchViewModel) {
        self.viewModel = viewModel
        self.viewModel?.delegate = self
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
    }
    
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }

}

// MARK: - UISearchResultsUpdating

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text
            else { return }
        viewModel?.initiate(searchTerm: text)
        collectionView.reloadData()
    }
    
}

// MARK: UICollectionViewDataSource

extension SearchViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.recipes?.count ?? 0
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.cellReuseIdentifier, for: indexPath) as? RecipeCell,
            let cellViewModel = viewModel?.recipeCellViewModel(at: indexPath.row)
            else { fatalError("Wrong cell type") }
        cell.configure(with: cellViewModel)
        return cell
    }

}

extension SearchViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}


// MARK: - View Model delegate

extension SearchViewController: SearchViewModelDelegate {
    
    func onFetchFailed(with reason: String) {
//        activityIndicator.stopAnimating()
//        let action = UIAlertAction(title: Constant.alertOK, style: .default)
//        displayAlert(with: Constant.alertTitle , message: reason, actions: [action])
    }
    
    
    
    
    func onFetchCompleted() {
        collectionView.isHidden = false
        collectionView.reloadData()
    }
    
}

