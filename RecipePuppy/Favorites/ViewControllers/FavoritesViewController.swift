//
//  FavoritesViewController.swift
//  RecipePuppy
//
//  Created by wearemobilefirst on 06/11/2019.
//  Copyright © 2019 badi. All rights reserved.
//

import UIKit
import Models

final class FavoritesViewController: UIViewController {
    
    private enum Constant {
        static let cellHeight: CGFloat = 300
    }
    
    private var dataSource: CollectionViewDataSource<Recipe>?
    private let viewModel: FavoritesViewModel
    private let collectionView =  UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    
    // MARK: - Life cycle
    
    init(with viewModel: FavoritesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        viewModel.delegate = self
        viewModel.initiate()
    }
    
    
    private func setupCollectionView() {
        collectionView.registerRecipeCell(RecipeCell.reuseIdentifier)
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.addConstraintsToFillSuperview()
        collectionView.delegate = self
    }
    
}

extension FavoritesViewController: FavoritesViewModelDelegate {
    
    func onFetchCompleted() {
        let dataSource = CollectionViewDataSource<Recipe>(
            models: viewModel.recipes,
            cellReuseIdentifier: RecipeCell.reuseIdentifier
        ) { [weak self] cell, indexPath in
            guard let recipeCell = cell as? RecipeCell else { return }
            self?.configure(recipeCell, indexPath)
        }
        
        self.dataSource = dataSource
        collectionView.dataSource = dataSource
    }
    
    
    func configure(_ cell: RecipeCell, _ indexPath: IndexPath) {
        guard let cellViewModel = viewModel.recipeCellViewModel(at: indexPath.row)
            else { return }
        
        cell.configure(with: cellViewModel)
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.bounds.width, height: Constant.cellHeight)
    }
    
}
