//
//  AppDependencies.swift
//  RecipesBook
//
//  Created by wearemobilefirst on 31/10/2019.
//  Copyright © 2019 badi. All rights reserved.
//

import Foundation
import RecipePuppyKit

/// The entire list of dependencies.
typealias Dependencies = RecipesRepositoryProviding

class DependencyProvider: Dependencies {

    let provider: RepositoryProvider
    let recipePuppyService: ServiceType


    required init(
        provider: RepositoryProvider,
        recipePuppyService: ServiceType
    ) {
        self.provider = provider
        self.recipePuppyService = recipePuppyService
    }
    
}
