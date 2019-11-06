//
//  RepositoryProvider.swift
//  RecipesBook
//
//  Created by wearemobilefirst on 31/10/2019.
//  Copyright © 2019 badi. All rights reserved.
//

import Foundation
import RecipePuppyKit

class RepositoryProvider {

    private let service: ServiceType
    private let store: RecipesStore
    

    lazy var recipesRepository: RecipesRepository = {
        return RecipesRepository(service: service, store: store)
    }()


    init(service: ServiceType, store: RecipesStore) {
        self.service = service
        self.store = store
    }
  
}
