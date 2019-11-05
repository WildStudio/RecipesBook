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

protocol DependenciesProviding {
    var provider: RepositoryProvider { get }
    var service: ServiceType { get }
}

class DependencyProvider: DependenciesProviding {

    let provider: RepositoryProvider
    let service: ServiceType


    required init(
        provider: RepositoryProvider,
        service: ServiceType
    ) {
        self.provider = provider
        self.service = service
    }
    
}
