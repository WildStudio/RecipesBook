//
//  SaveRecipesUseCase.swift
//  RecipePuppy
//
//  Created by wearemobilefirst on 06/11/2019.
//  Copyright © 2019 badi. All rights reserved.
//

import Foundation
import Models

struct FavoritesRecipesUseCase: FavoritesRecipesUseCaseType {
    
    private let repository: RecipesRepository
    
    
    init(repository: RecipesRepository) {
        self.repository = repository
    }
    
    
    func favorite(_ recipe: Recipe) {
        repository.favorite(recipe)
    }
    
    
    func isfavorite(_ recipe: Recipe) -> Bool {
        repository.isFavorite(recipe)
    }

}

protocol FavoritesRecipesUseCaseType {
    func favorite(_ recipe: Recipe)
    func isfavorite(_ recipe: Recipe) -> Bool
}
