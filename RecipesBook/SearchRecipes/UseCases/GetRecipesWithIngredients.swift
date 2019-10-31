//
//  GetRecipesWithIngredients.swift
//  RecipesBook
//
//  Created by wearemobilefirst on 31/10/2019.
//  Copyright © 2019 badi. All rights reserved.
//

import Foundation
import Models

struct GetRecipesWithIngredients {

    private let repository: RecipesRepository

    
    init(repository: RecipesRepository) {
        self.repository = repository
    }

    
    func execute(
        _ ingredients: String,
        completion: @escaping (Result<[Recipe], Error>) -> Void
    ) {
        repository.get(with: ingredients, completion: completion)
    }

}
