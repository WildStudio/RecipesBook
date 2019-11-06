//
//  RecipeCellViewModel.swift
//  RecipePuppy
//
//  Created by wearemobilefirst on 02/11/2019.
//  Copyright © 2019 badi. All rights reserved.
//

import Foundation
import Models

final class RecipeCellViewModel {
    
    private enum Constant {
        static let tagText = "Has lactose"
    }
    
    var ingredients: String {
        recipe.ingredients
    }
    
    var title: String {
        recipe.title
    }
    
    var tag: String {
        Constant.tagText
    }
    
    var shouldHideTagLabel: Bool {
        !recipe.hasLactose
    }
    
    var imageURL: URL? {
        recipe.thumbnailURL
    }
    
    var isFavourite: Bool {
        favoritesRecipes.isfavorite(recipe)
    }
    
    private let recipe: Recipe
    private let favoritesRecipes: FavoritesRecipesUseCaseType
    
    
    init(_ recipe: Recipe, _ favoritesRecipes: FavoritesRecipesUseCaseType) {
        self.recipe = recipe
        self.favoritesRecipes = favoritesRecipes
    }
    
    
    func favorite() {
        favoritesRecipes.favorite(recipe)
    }
    
}
