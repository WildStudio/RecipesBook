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
        return recipe.ingredients
    }
    
    var title: String {
        return recipe.title
    }
    
    var tag: String {
        Constant.tagText
    }
    
    var shouldHideTagLabel: Bool {
        return !recipe.hasLactose
    }
    
    private let recipe: Recipe
    
    
    init(_ recipe: Recipe) {
        self.recipe = recipe
    }
    
}
