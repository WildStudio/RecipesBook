//
//  RecipeCellViewModelTests.swift
//  RecipePuppyTests
//
//  Created by wearemobilefirst on 06/11/2019.
//  Copyright © 2019 badi. All rights reserved.
//

@testable import RecipePuppy
import XCTest

class RecipeCellViewModelTests: XCTestCase {
    
    var favorites: FavoritesRecipesUseCase!
    
    
    override func setUp() {
        super.setUp()
        favorites = FavoritesRecipesUseCase(
            repository: RecipesRepository(
                service: MockServiceProvider.service(),
                store: RecipesStore()
            )
        )
    }
    
    
    override func tearDown() {
        favorites.clear()
        super.tearDown()
    }
    
    
    func testRecipe_ReturnsCorrectRecipe() {
        // Given / When
        let recipe = MockConstant.firstRecipe
        
        let viewModel = RecipeCellViewModel(recipe, favorites)
        
        // Then
        XCTAssertEqual(recipe.title, viewModel.title)
        XCTAssertEqual(recipe.thumbnailURL, viewModel.imageURL)
        XCTAssertEqual(recipe.ingredients, viewModel.ingredients)
        XCTAssertEqual(!recipe.hasLactose, viewModel.shouldHideTagLabel)
    }
    
    
    func testAddToFavourite_ReturnsFavourite() {
        // Given
        let recipe = MockConstant.firstRecipe
        let viewModel = RecipeCellViewModel(recipe,favorites)
        
        // When
        viewModel.favorite()
        
        // Then
        XCTAssertTrue(viewModel.isFavourite)
    }
    
    
    func testNonFavorite_ReturnsFalse() {
        // Given / When
        let recipe = MockConstant.secondRecipe
        let viewModel = RecipeCellViewModel(recipe, favorites)
        
        
        // Then
        XCTAssertFalse(viewModel.isFavourite)
    }
    
}
