//
//  RootCoordinator.swift
//  RecipesBook
//
//  Created by wearemobilefirst on 31/10/2019.
//  Copyright © 2019 badi. All rights reserved.
//

import UIKit
import RecipePuppyKit

final class RootCoordinator: Coordinator {
    
    
    // MARK: - Properties
    
    var children = [AnyObject]()
    let root: UINavigationController
    let searchViewController: SearchViewController
    let mediator = RouteMediator()
    private var child: ChildCoordinator?
    
    
    // MARK: - Life cycle
    
    init(dependencyProvider: DependencyProvider, root: UINavigationController) {
        self.root = root
        guard let searchViewController = root.viewControllers.first as? SearchViewController else {
                fatalError("The initial view controller should be set to a SearchViewController embedded into a UINavigationController!")
        }
       searchViewController.configure(with: SearchViewModel(
                getRecipes: GetRecipesWithIngredients(
                    repository: dependencyProvider.provider.recipesRepository
                ),
                routeMediator: mediator
            )
        )
        
        self.searchViewController = searchViewController
        
        setup()
    }
    
    
    private func setup() {
        mediator.onRouteRequest = { [weak self] destination in
            self?.handleRouteRequest(to: destination)
        }
    }
    
    
    private func handleRouteRequest(to destination: RouteMediator.Destination) {
        switch destination {
        case .detail: presentDetail()
        case .alert(let configuration):
            showAlert(with: configuration)
        }
    }
    
    
    private func presentDetail() {
        
    }
    
    
    private func showAlert(with configuration: AlertConfiguration) {
        searchViewController.displayAlert(with: configuration)
    }
    
    
}


// MARK: - Mediator

extension RootCoordinator {
    
    final class RouteMediator: RouteMediating {
        
        enum Destination: Equatable {
            case detail
            case alert(AlertConfiguration)
        }
        
        var onRouteRequest: ((Destination) -> Void)?
        
        var currentLocation: Destination?
        
        
        func route(to destination: Destination) {
            currentLocation = destination
            onRouteRequest?(destination)
        }
        
    }
    
}
