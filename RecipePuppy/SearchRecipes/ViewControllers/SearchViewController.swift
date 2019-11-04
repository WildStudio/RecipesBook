//
//  SearchViewController.swift
//  RecipesBook
//
//  Created by wearemobilefirst on 31/10/2019.
//  Copyright © 2019 badi. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController, AlertControllerDisplayable {
    
    private enum Constant {
        static let cellReuseIdentifier = "cell"
        static let alertTitle = "Something went wrong"
        static let alertOK = "OK"
        static let searchBarPlaceholder = "Start typing to search recipes..."
        static let prefetchingCell = 5
    }
    
    private var timer: Timer?
    private var search: UISearchController?
    private var viewModel: SearchViewModel?
    private var searchBarInitialLeftView: UIView?
    
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.hidesWhenStopped = true
        spinner.color = .gray
        return spinner
    }()
    
    lazy private var emptyStateController = EmptyStateViewController()
    
    @IBOutlet private var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet private var collectionView: UICollectionView!
    
    
    // MARK: - Life cycle
    
    func configure(with viewModel: SearchViewModel) {
        self.viewModel = viewModel
        self.viewModel?.delegate = self
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel?.title
        setupSearchController()
        setupCollectionView()
        addEmptyState()
    }
    
    
    private func addEmptyState() {
        embed(emptyStateController)
        embedView(emptyStateController.view, in: view)
        emptyStateController.setupView(with: "Welcome to the Recipe Puppy App", subtitle: "What are you waiting for? Start typing to search recipes with ingredients.")
    }
    
    
    private func removeEmptyState() {
        remove(emptyStateController)
    }
    
    
    private func setupSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        search = searchController
        search?.searchResultsUpdater = self
        search?.obscuresBackgroundDuringPresentation = false
        search?.searchBar.placeholder = Constant.searchBarPlaceholder
        searchBarInitialLeftView = search?.searchBar.searchTextField.leftView
        navigationItem.searchController = search
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    
    private func refreshView() {
        removeEmptyState()
        spinner.stopAnimating()
        search?.searchBar.searchTextField.leftView = searchBarInitialLeftView
        collectionView.reloadData()
    }
    
}

// MARK: - UISearchResultsUpdating

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text
            else { return }
        searchController.searchBar.searchTextField.leftView = spinner
        spinner.startAnimating()
        viewModel?.initiate(searchQuery: text)
    }
    
}

// MARK: - UICollectionViewDataSource

extension SearchViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.recipes?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constant.cellReuseIdentifier,
            for: indexPath
            ) as? RecipeCell,
            let cellViewModel = viewModel?.recipeCellViewModel(at: indexPath.row)
            else { fatalError("Wrong cell type") }
        
        cell.configure(with: cellViewModel)
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate

extension SearchViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}


// MARK: - View Model delegate

extension SearchViewController: SearchViewModelDelegate {
    
    func onFetchFailed(with reason: String) {
        
    }
    
    
    func onFetchCompleted() {
        refreshView()
    }
    
}

