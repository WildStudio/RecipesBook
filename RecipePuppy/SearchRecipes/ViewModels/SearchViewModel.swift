//
//  SearchViewModel.swift
//  RecipesBook
//
//  Created by wearemobilefirst on 31/10/2019.
//  Copyright © 2019 badi. All rights reserved.
//

import Foundation
import Models

class SearchViewModel {
    
    private let getRecipes: GetRecipesWithIngredients
    private let routeMediator: RootCoordinator.RouteMediator
    
    private(set) var recipes: [Recipe]?
    
    init(
        getRecipes: GetRecipesWithIngredients,
        routeMediator: RootCoordinator.RouteMediator
    ) {
        self.getRecipes = getRecipes
        self.routeMediator = routeMediator
    }
    
    func initiate() {
        fetchRecipes(with: "onions")
    }
    
    
    private func fetchRecipes(with ingredients: String = .init()) {
        getRecipes.execute(ingredients) { [weak self] result in
            switch result {
            case .success(let recipes):
                self?.recipes = recipes
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}
