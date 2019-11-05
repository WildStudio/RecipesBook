//
//  GetRecipesWithIngredients.swift
//  RecipesBook
//
//  Created by wearemobilefirst on 31/10/2019.
//  Copyright © 2019 badi. All rights reserved.
//

import Foundation
import Models

struct GetRecipesWithIngredients: GetRecipesUsesCaseType {

    private let repository: RecipesRepository

    
    init(repository: RecipesRepository) {
        self.repository = repository
    }

    
    func execute(
        _ ingredients: String,
        page: Int?,
        completion: @escaping (Result<[Recipe], Error>) -> Void
    ) {
        repository.get(with: ingredients, page: page, completion: completion)
    }

}

protocol GetRecipesUsesCaseType {
    func execute( _ ingredients: String,
           page: Int?,
           completion: @escaping (Result<[Recipe], Error>) -> Void
       )
}
