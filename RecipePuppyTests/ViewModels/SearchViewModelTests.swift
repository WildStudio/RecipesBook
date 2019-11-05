//
//  SearchViewModelTests.swift
//  RecipePuppyTests
//
//  Created by wearemobilefirst on 05/11/2019.
//  Copyright © 2019 badi. All rights reserved.
//

import XCTest
import Models
@testable import RecipePuppy

class SearchViewModelTests: XCTestCase {
    
    var viewModel: SearchViewModel!
    var mediator: RootCoordinator.RouteMediator!
    var invokedRecipeRoute: Recipe?
    var didRouteToAlert = false
    var mockUseCase: GetRecipesWithIngredients!
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    
    
    override func setUp() {
        super.setUp()
        mediator = RootCoordinator.RouteMediator()
        mediator.onRouteRequest = { destination in
            switch destination {
            case .alert: self.didRouteToAlert = true
            case .detail(let recipe): self.invokedRecipeRoute = recipe
            }
        }
        
        mockUseCase = GetRecipesWithIngredients(
            repository: RepositoryProvider(
                service: MockServiceProvider.service()
            ).recipesRepository
        )
        
        viewModel = SearchViewModel(getRecipes: mockUseCase, routeMediator: mediator)
    }
}
