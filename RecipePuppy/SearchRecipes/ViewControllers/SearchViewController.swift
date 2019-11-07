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
        static let searchBarPlaceholder = "Start typing to search recipes..."
        static let prefetchingCell = 5
    }
    
    private var search: UISearchController?
    private var viewModel: SearchViewModel?
    private var searchBarInitialLeftView: UIView?
    
    private lazy var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.hidesWhenStopped = true
        spinner.color = .gray
        return spinner
    }()
    
    lazy private var emptyStateController: EmptyStateViewController = .searchEmptyState()
    
    @IBOutlet private var collectionView: UICollectionView!
    
    
    // MARK: - Dependecy injection & observe state
    
    func configure(with viewModel: SearchViewModel) {
        self.viewModel = viewModel
        
        viewModel.onViewStateChange = { [weak self] state in
            self?.handle(state)
        }
    }
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel?.title
        setupSearchController()
        setupCollectionView()
        addEmptyState()
        addFavoritesButton()
    }
    
    
    private func addFavoritesButton() {
        let barButtonItem = UIBarButtonItem(
            barButtonSystemItem: .bookmarks,
            target: self,
            action: #selector(onFavorites)
        )
        barButtonItem.tintColor = .systemGreen
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    
    private func addEmptyState() {
        embed(emptyStateController)
        embedView(emptyStateController.view, in: view)
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
        collectionView.prefetchDataSource = self
        collectionView.registerRecipeCell(RecipeCell.reuseIdentifier)
    }
    
    
    private func refreshView() {
        removeEmptyState()
        spinner.stopAnimating()
        search?.searchBar.searchTextField.leftView = searchBarInitialLeftView
        collectionView.reloadData()
    }
    
    
    @objc func onFavorites() {
        viewModel?.didSelectFavorites()
    }
    
    
    private func handle(_ state: ViewState) {
        switch state {
        case .empty:
            addEmptyState()
        case .ready:
            removeEmptyState()
            spinner.stopAnimating()
            search?.searchBar.searchTextField.leftView = searchBarInitialLeftView
            collectionView.reloadData()
        case .loading:
            removeEmptyState()
            search?.searchBar.searchTextField.leftView = spinner
            spinner.startAnimating()
        default:
            break
        }
    }
    
}

// MARK: - UISearchResultsUpdating

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text
            else { return }
        viewModel?.initiate(searchQuery: text)
    }
    
}

// MARK: - UICollectionViewDataSource

extension SearchViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.recipes.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RecipeCell.reuseIdentifier,
            for: indexPath
            ) as? RecipeCell
            else {
                return UICollectionViewCell()
        }
        
        let cellViewModel = viewModel?.recipeCellViewModel(at: indexPath.row)
        cell.configure(with: cellViewModel)
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate

extension SearchViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.didSelectCell(at: indexPath)
    }
}


// MARK: - UICollectionViewDataSourcePrefetching

extension SearchViewController: UICollectionViewDataSourcePrefetching {
    
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        guard let viewModel = viewModel else { return false }
        return indexPath.row >= viewModel.recipes.count - Constant.prefetchingCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            viewModel?.fetchRecipes()
        }
    }
    
}
