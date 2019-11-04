//
//  RecipesRepository.swift
//  RecipesBook
//
//  Created by wearemobilefirst on 31/10/2019.
//  Copyright © 2019 badi. All rights reserved.
//

import Foundation
import Models
import RecipePuppyKit

struct RecipesRepository {
    
    private let service: ServiceType
    
    
    init(service: ServiceType) {
        self.service = service
    }
    
    
    func get(
        with ingredients: String,
        completion: @escaping (Result<[Recipe], Error>) -> Void
    ) {
        service.fetchRecipes(ingredients: ingredients) { response  in
            switch response {
            case .success(let recipes):
                completion(.success(recipes))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
        
}
