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
    

    lazy var recipesRepository: RecipesRepository = {
        return RecipesRepository(service: service)
    }()


    init(service: ServiceType) {
        self.service = service
    }
  
}
