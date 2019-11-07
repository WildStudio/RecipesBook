//
//  RouteMediating.swift
//  RecipesBook
//
//  Created by wearemobilefirst on 31/10/2019.
//  Copyright © 2019 badi. All rights reserved.
//

import Foundation

/// Type which mediates routing to supported destinations as defined in `Destination`
public protocol RouteMediating {
    
    associatedtype Destination
    
    /// Mediate a route request to owner to facilitate route to destination.
    /// If mediator has no owner, no route will be executed.
    func route(to destination: Destination)
    
}
