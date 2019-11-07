//
//  Coordinator.swift
//  RecipesBook
//
//  Created by wearemobilefirst on 31/10/2019.
//  Copyright © 2019 badi. All rights reserved.
//

import Foundation

/// A coordinator is a top level citizen which holds on to a mediator which is used
/// to communicate with View Models and request routes.
/// A coordinator does not interact with View Models, only with the `Mediator`.
public protocol Coordinator {
    
    associatedtype RouteMediator: RouteMediating
    
    /// A Navigation Mediator which allows route requests to the Coordinator
    /// through opaque communication.
    var mediator: RouteMediator { get }
    
}


/// A Coordinator which also requires knowledge of the parent to notify intent
/// as a child flow.
public protocol ChildCoordinator: AnyObject {
    
    /// Parent coordinator.
    var parent: ParentCoordinator? { get }
    
}


/// Type which allows children Coordinators to notify parents when they are done.
public protocol ParentCoordinator: AnyObject {
    
    /// Function invoked on the parent when called from children.
    /// This could remove the entire childs flow if the parent requires it.
    func done()

}
