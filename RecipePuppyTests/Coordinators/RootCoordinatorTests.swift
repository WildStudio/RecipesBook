//
//  RootCoordinatorTests.swift
//  RecipePuppyTests
//
//  Created by wearemobilefirst on 05/11/2019.
//  Copyright © 2019 badi. All rights reserved.
//

import UIKit
import XCTest
@testable import RecipePuppy

class RootCoordinatorTests: WindowTestCase {
    
    var navigationController: UINavigationController!
    var coordinator: RootCoordinator!
    var dependencyProvider: DependencyProvider!
    
    
    override func setUp() {
        super.setUp()
        
        let service = MockServiceProvider.service()
        let store = RecipesStore()
        navigationController = UINavigationController()
        navigationController.viewControllers = [(SearchViewController.instantiate() ?? SearchViewController())]
        dependencyProvider = DependencyProvider(provider: RepositoryProvider(service: service, store: store), service: service)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        coordinator = RootCoordinator(dependencyProvider: dependencyProvider, root: navigationController)
    }
    
    func testMediatorRoute_WhenAlert_PresentsAlert() {
        // Given
        let configuration = AlertConfiguration.build()
        // When
        coordinator.mediator.route(to: .alert(configuration))
        // Then
        XCTAssertAlert()
        XCTAssertTrue(presentedAlertController! == configuration)
    }
}

