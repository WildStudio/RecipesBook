//
//  SearchViewModel.swift
//  RecipesBook
//
//  Created by wearemobilefirst on 31/10/2019.
//  Copyright © 2019 badi. All rights reserved.
//

import Foundation

class SearchViewModel {
    
    private let getRecipes: GetRecipesWithIngredients

    init(getRecipes: GetRecipesWithIngredients) {
        self.getRecipes = getRecipes
    }
}
