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
    
    
    func testRecipe_ReturnsCorrectRecipe() {
        // Given
        let recipe = MockConstant.firstRecipe
        
        // When
        let viewModel = RecipeCellViewModel(recipe)
        
        // Then
        XCTAssertEqual(recipe.title, viewModel.title)
        XCTAssertEqual(recipe.thumbnailURL, viewModel.imageURL)
        XCTAssertEqual(recipe.ingredients, viewModel.ingredients)
        XCTAssertEqual(!recipe.hasLactose, viewModel.shouldHideTagLabel)
    }
    
}
