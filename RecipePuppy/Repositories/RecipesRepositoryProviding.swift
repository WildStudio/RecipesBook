//
//  RecipesRepositoryProviding.swift
//  RecipesBook
//
//  Created by wearemobilefirst on 31/10/2019.
//  Copyright © 2019 badi. All rights reserved.
//

import Foundation
import RecipePuppyKit

protocol RecipesRepositoryProviding {

    func make(with service: ServiceType, store: RecipesStore) -> RecipesRepository
}


// MARK: - RecipesRepositoryProviding

extension RecipesRepositoryProviding {

    func make(with service: ServiceType, store: RecipesStore) -> RecipesRepository {
        return RecipesRepository(service: service, store: store)
    }

}

