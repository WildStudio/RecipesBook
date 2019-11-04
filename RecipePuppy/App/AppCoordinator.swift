//
//  AppCoordinator.swift
//  RecipesBook
//
//  Created by wearemobilefirst on 31/10/2019.
//  Copyright © 2019 badi. All rights reserved.
//

import UIKit


final class AppCoordinator {
    
    // MARK: - Properties
    
    private let dependencyProvider: DependencyProvider
    private var rootCoordinator: RootCoordinator?
    
    
    // MARK: - Life cycle
    
    required init(dependencyProvider: DependencyProvider) {
        self.dependencyProvider = dependencyProvider
    }
    
    
    // MARK: - Setup
    
    func setup(for viewController: UINavigationController) {
        setupRoot(for: viewController)
    }
    
    
    private func setupRoot(for viewController: UINavigationController) {
        let coordinator = RootCoordinator(dependencyProvider: dependencyProvider, root: viewController)
        rootCoordinator = coordinator
    }
    
}


