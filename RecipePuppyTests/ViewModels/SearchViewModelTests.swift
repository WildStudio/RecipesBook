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
    var mockUseCase: MockGetRecipesUseCase!
    
    
    override func setUp() {
        super.setUp()
        mediator = RootCoordinator.RouteMediator()
        mediator.onRouteRequest = { destination in
            switch destination {
            case .alert: self.didRouteToAlert = true
            case .detail(let recipe): self.invokedRecipeRoute = recipe
            case .favorites:
                break
            }
        }
        
        mockUseCase = MockGetRecipesUseCase()
        
        viewModel = SearchViewModel(getRecipes: mockUseCase,
                                    favoritesRecipes: FavoritesRecipesUseCase(
                                        repository: RecipesRepository(
                                            service: MockServiceProvider.service(),
                                            store: RecipesStore()
                                        )
            ),
                                    routeMediator: mediator)
    }
    
    
    func testInitiate_WhenHasRecipes_PopulatesCollectionView() {
        // Given
        mockUseCase.result = .success([MockConstant.firstRecipe])
        
        // When
        viewModel.initiate(searchQuery: "stuff")
        
        // Then
        XCTAssertEqual(viewModel.recipes.count, 1)
    }
    
    
    func testInitiate_WhenRecipeNotFound_DoesNotPopulateCollectionView() {
        // Given
        mockUseCase.result = .failure(TestError())
        
        // When
        viewModel.initiate(searchQuery: "stuff")
        
        // Then
        XCTAssertEqual(viewModel.recipes.count,  0)
    }
    
    
    func testInitiateError_RoutesToAlert() {
        // Given
        mockUseCase.result = .failure(TestError())
        
        // When
        viewModel.initiate(searchQuery: "stuff")
        
        // Then
        XCTAssertTrue(didRouteToAlert)
    }
    
    
    func testDidSelectCell_WhenRecipeCell_RoutesToRecipeDestination() {
        // Given
        mockUseCase.result = .success([MockConstant.firstRecipe, MockConstant.secondRecipe])
        viewModel.initiate(searchQuery: "mock recipes")
        
        // When
        viewModel.didSelectCell(at: IndexPath(item: 0, section: 0))
        
        // Then
        XCTAssertEqual(invokedRecipeRoute, MockConstant.firstRecipe)
    }
    
}
