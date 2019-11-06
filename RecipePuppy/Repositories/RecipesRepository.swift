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
    private let store: RecipesStore
    
    
    init(service: ServiceType, store: RecipesStore) {
        self.service = service
        self.store = store
    }
    
    
    func get(
        with ingredients: String,
        page: Int? = nil,
        completion: @escaping (Result<[Recipe], Error>) -> Void
    ) {
        service.fetchRecipes(ingredients: ingredients, page: page) { response  in
            switch response {
            case .success(let recipes):
                completion(.success(recipes))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    func favorite(_ recipe: Recipe) {
        isFavorite(recipe) ? remove(recipe) : add(recipe)
    }
    
    
    func isFavorite(_ recipe: Recipe) -> Bool {
        return store.contains(recipe)
    }
    
    
    func clear() {
        store.clear()
    }
    
    
    private func add(_ recipe: Recipe) {
        store.add(recipe)
    }
    
    
    private func remove(_ recipe: Recipe) {
        store.remove(recipe)
    }
    
}
