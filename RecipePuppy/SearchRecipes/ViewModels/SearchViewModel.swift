//
//  SearchViewModel.swift
//  RecipesBook
//
//  Created by wearemobilefirst on 31/10/2019.
//  Copyright © 2019 badi. All rights reserved.
//

import Foundation
import Models

protocol SearchViewModelDelegate: AnyObject {
    func onFetchCompleted()
    func onFetchFailed(with reason: String)
}


class SearchViewModel {
    
    private enum Constant {
        static let updateIntervalInMilliSeconds = 400
        static let minimumCharacters = 2
    }
    
    private let getRecipes: GetRecipesWithIngredients
    private let routeMediator: RootCoordinator.RouteMediator
    
    private(set) var recipes: [Recipe]?
    
    weak var delegate: SearchViewModelDelegate?
    
    init(
        getRecipes: GetRecipesWithIngredients,
        routeMediator: RootCoordinator.RouteMediator
    ) {
        self.getRecipes = getRecipes
        self.routeMediator = routeMediator
    }
    
    func initiate(searchTerm: String) {
        fetchRecipes(with: searchTerm)
    }
    
    // Returns a `RecipeCellViewModel`
    ///- Parameters:
    ///     - index: the given index
    func recipeCellViewModel(at index: Int) -> RecipeCellViewModel? {
        guard let recipe =  recipes?[index]
            else { return nil }
        return RecipeCellViewModel(recipe)
    }
    
    
    // Handle the results
    /// - Parameters:
    ///     - result: A value that represents either a success or a failure, including an associated value in each case.
    private func handleResult(_ result: Result<[Recipe], Error>) {
        switch result {
        case .success(let recipes):
            self.recipes = recipes
            delegate?.onFetchCompleted()
        case .failure(let error):
            delegate?.onFetchFailed(with: error.localizedDescription)
        }
    }
    
     // TODO: avoid spamming server
    private func fetchRecipes(with ingredients: String = .init()) {
        if ingredients.count > Constant.minimumCharacters {
            getRecipes.execute(ingredients) { [weak self] result in
                self?.handleResult(result)
            }
        }
    }
        
}
