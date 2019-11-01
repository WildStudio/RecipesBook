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
    
    func setup(for window: UIWindow?) {
        setupRoot(for: window)
    }
    
    
    private func setupRoot(for window: UIWindow?) {
        let coordinator = RootCoordinator(dependencyProvider: dependencyProvider)
        window?.rootViewController = coordinator.root
        window?.makeKeyAndVisible()
        rootCoordinator = coordinator
    }
    
}


