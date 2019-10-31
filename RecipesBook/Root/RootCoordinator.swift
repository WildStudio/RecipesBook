//
//  RootCoordinator.swift
//  RecipesBook
//
//  Created by wearemobilefirst on 31/10/2019.
//  Copyright © 2019 badi. All rights reserved.
//

import Foundation
import RecipePuppyKit

final class RootCoordinator: Coordinator {
    
    
    // MARK: - Properties
    
    var children = [AnyObject]()
    let root: SearchViewController
    let mediator = RouteMediator()
    private var child: ChildCoordinator?
    
    
    // MARK: - Life cycle
    
    init(dependencyProvider: Dependencies) {
        root = SearchViewController(
            viewModel: SearchViewModel(
                getRecipes: GetRecipesWithIngredients(
                    repository: RecipesRepository(
                        service: Service(serverConfig: ServerConfig(apiBaseUrl: URL(string: "")!))
                    )
                ),
                routeMediator: mediator
            )
        )
        
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
        }
    }
    
    
    private func presentDetail() {
        
    }
    
    
}


// MARK: - Mediator

extension RootCoordinator {
    
    final class RouteMediator: RouteMediating {
        
        enum Destination: Equatable {
            case detail
        }
        
        var onRouteRequest: ((Destination) -> Void)?
        
        var currentLocation: Destination?
        
        
        func route(to destination: Destination) {
            currentLocation = destination
            onRouteRequest?(destination)
        }
        
    }
    
}
