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
        static let title = "Recipes"
        static let minimumCharacters = 2
        static let updateIntervalInSeconds = 0.4
    }
    
    private var timer: Timer?
    private let getRecipes: GetRecipesWithIngredients
    private let routeMediator: RootCoordinator.RouteMediator
    
    private(set) var recipes: [Recipe]?
    
    weak var delegate: SearchViewModelDelegate?
    
    let title = Constant.title
    
    init(
        getRecipes: GetRecipesWithIngredients,
        routeMediator: RootCoordinator.RouteMediator
    ) {
        self.getRecipes = getRecipes
        self.routeMediator = routeMediator
    }
    
    func initiate(searchQuery: String) {
        fetchRecipes(with: searchQuery)
    }
    
    /// Returns a `RecipeCellViewModel`
    ///- Parameters:
    ///     - index: the given index
    func recipeCellViewModel(at index: Int) -> RecipeCellViewModel? {
        guard let recipe =  recipes?[safe: index]
            else { return nil }
        return RecipeCellViewModel(recipe)
    }
    
    
    /// Handle the search results
    /// - Parameters:
    ///     - result: A value that represents either a success or a failure, including an associated value in each case.
    private func handleResult(_ result: Result<[Recipe], Error>) {
        switch result {
        case .success(let recipes):
            self.recipes = recipes
            delegate?.onFetchCompleted()
        case .failure(let error):
            let configuration = AlertConfiguration(
                body: error.localizedDescription
            )
            routeMediator.route(to: .alert(configuration))
        }
    }
    
    
    private func fetchRecipes(with searchQuery: String = .init()) {
        if searchQuery.count > Constant.minimumCharacters {
            timer?.invalidate()
            timer = Timer.scheduledTimer(
                withTimeInterval: Constant.updateIntervalInSeconds,
                repeats: false
            ) { [weak self] _ in
                self?.getRecipes.execute(searchQuery) { [weak self] result in
                    self?.handleResult(result)
                }
                self?.timer?.invalidate()
            }
        }
    }
        
}
