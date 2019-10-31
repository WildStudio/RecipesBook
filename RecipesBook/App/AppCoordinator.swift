//
//  AppCoordinator.swift
//  RecipesBook
//
//  Created by wearemobilefirst on 31/10/2019.
//  Copyright © 2019 badi. All rights reserved.
//

import Foundation

final class AppCoordinator {
    
    // MARK: - Properties
    
    
    
    // MARK: - Life cycle
    
    required init() {
        
    }
    
    private func setupRoot(for window: UIWindow?) {
        let coordinator = RootCoordinator(dependencyProvider: dependencyProvider)
        window?.rootViewController = coordinator.root
        window?.makeKeyAndVisible()
        rootCoordinator = coordinator
    }
    
}

}
