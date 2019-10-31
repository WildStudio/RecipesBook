//
//  AppDelegate.swift
//  RecipesBook
//
//  Created by wearemobilefirst on 31/10/2019.
//  Copyright © 2019 badi. All rights reserved.
//

import UIKit
import RecipePuppyKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)

    private lazy var appCoordinator: AppCoordinator = {
        return AppCoordinator(dependencyProvider: dependencyProvider)
    }()
    
    private lazy var dependencyProvider: DependencyProvider = {
           return makeDependencyProvider(service: Service(serverConfig: ServerConfig(apiBaseUrl: URL(string: "http://www.recipepuppy.com/")!)))
    }()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        appCoordinator.setup(for: window)
        return true
    }

    
    private func makeDependencyProvider(service: ServiceType) -> DependencyProvider {
        let repositoryProvider = RepositoryProvider(service: service)
        return DependencyProvider(provider: repositoryProvider, recipePuppyService: service)
    }


}

