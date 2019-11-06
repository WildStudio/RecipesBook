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
}

final class SearchViewModel {
    
    private enum Constant {
        static let title = "Recipes"
        static let minimumCharacters = 2
        static let updateIntervalInSeconds = 0.4
    }
    
    private var timer: Timer?
    private var currentPage = 1
    private var searchQuery = String.init()
    private let getRecipes: GetRecipesUsesCaseType
    private let favoritesRecipes: FavoritesRecipesUseCaseType
    private let routeMediator: RootCoordinator.RouteMediator
    
    private(set) var recipes = [Recipe]()
    
    weak var delegate: SearchViewModelDelegate?
    
    let title = Constant.title
    
    init(
        getRecipes: GetRecipesUsesCaseType,
        favoritesRecipes: FavoritesRecipesUseCaseType,
        routeMediator: RootCoordinator.RouteMediator
    ) {
        self.getRecipes = getRecipes
        self.favoritesRecipes = favoritesRecipes
        self.routeMediator = routeMediator
    }
    
    /// Intiate searching a `Recipe`
    ///- Parameters:
    ///     - searchQuery: one or multiple ingredients
    func initiate(searchQuery: String) {
        self.searchQuery = searchQuery.lowercased()
        recipes.removeAll()
        fetchRecipes()
    }
    
    
    // TODO: - avoid spamming the server
    func fetchRecipes() {
        if searchQuery.count > Constant.minimumCharacters {
            getRecipes.execute(searchQuery, page: currentPage) { [weak self] result in
                self?.handleResult(result)
            }
        }
    }
    
    
    // MARK: - User Actions
    
    func didSelectCell(at indexPath: IndexPath) {
        guard let recipe = recipes[safe: indexPath.row]
            else { return }
        routeMediator.route(to: .detail(recipe))
    }
    
    
    func didSelectFavorites() {
        routeMediator.route(to: .favorites)
    }
    
    
    /// Returns a `RecipeCellViewModel`
    ///- Parameters:
    ///     - index: the given index
    func recipeCellViewModel(at index: Int) -> RecipeCellViewModel? {
        guard let recipe =  recipes[safe: index]
            else { return nil }
        return RecipeCellViewModel(recipe, favoritesRecipes)
    }
    
    
    /// Handle the search results
    /// - Parameters:
    ///     - result: A value that represents either a success or a failure, including an associated value in each case.
    private func handleResult(_ result: Result<[Recipe], Error>) {
        switch result {
        case .success(let recipes):
            self.recipes.append(contentsOf: recipes)
            currentPage += 1
            delegate?.onFetchCompleted()
        case .failure(let error):
            let configuration = AlertConfiguration(
                body: error.localizedDescription
            )
            routeMediator.route(to: .alert(configuration))
        }
    }
    
}
