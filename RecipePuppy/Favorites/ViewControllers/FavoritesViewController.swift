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
        static let cellReuseIdentifier = "cell"
    }
    
    private var dataSource: CollectionViewDataSource<Recipe>?
    private let viewModel: FavoritesViewModel
    private let collectionView =  UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    lazy private var emptyStateController = EmptyStateViewController()
    
    
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
        collectionView.register(RecipeCell.nib(), forCellWithReuseIdentifier: Constant.cellReuseIdentifier)
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.addConstraintsToFillSuperview()
    }
    
}

extension FavoritesViewController: FavoritesViewModelDelegate {
    
    func onFetchCompleted() {
        let dataSource = CollectionViewDataSource<Recipe>(
            models: viewModel.recipes,
            cellReuseIdentifier: Constant.cellReuseIdentifier
        ) { [weak self] recipes, cell in
            guard let recipeCell = cell as? RecipeCell else { return }
            self?.configure(cell: recipeCell)
        }
        
        self.dataSource = dataSource
        collectionView.dataSource = dataSource
    }
    
    
    func configure(cell: RecipeCell) {
        guard let indexPath = collectionView.indexPath(for: cell)?.row,
        let viewModel = viewModel.recipeCellViewModel(at: indexPath)
        else { return }
        
        cell.configure(with: viewModel)
    }
    
}


