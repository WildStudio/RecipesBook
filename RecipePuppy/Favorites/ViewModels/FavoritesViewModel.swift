//
//  FavoritesViewModel.swift
//  RecipePuppy
//
//  Created by wearemobilefirst on 06/11/2019.
//  Copyright © 2019 badi. All rights reserved.
//

import Foundation
import Models

protocol FavoritesViewModelDelegate: AnyObject {
    func onFetchCompleted()
}

final class FavoritesViewModel {
    
    private let favoritesRecipes: FavoritesRecipesUseCaseType
    private(set) var recipes = [Recipe]()
    
    weak var delegate: FavoritesViewModelDelegate?
    
    
    init(favoritesRecipes: FavoritesRecipesUseCaseType) {
        self.favoritesRecipes = favoritesRecipes
    }
    
    
    func initiate() {
        recipes = favoritesRecipes.get()
        delegate?.onFetchCompleted()
    }
    
    
    /// Returns a `RecipeCellViewModel`
    ///- Parameters:
    ///     - index: the given index
    func recipeCellViewModel(at index: Int) -> RecipeCellViewModel? {
        guard let recipe =  recipes[safe: index]
            else { return nil }
        return RecipeCellViewModel(recipe, favoritesRecipes)
    }
    
}
