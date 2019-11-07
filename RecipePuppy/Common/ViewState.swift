//
//  ViewState.swift
//  RecipePuppy
//
//  Created by wearemobilefirst on 07/11/2019.
//  Copyright © 2019 badi. All rights reserved.
//

import Foundation

/// Enum describing the available states of a view
public enum ViewState {
    /// Initial state and state where no data is available
    case empty
    /// State when the data is being loaded
    case loading
    /// State when new data is available to the view
    case ready
    /// State when an error has occured and should be reflected in the view
    case error(Error)
}


public protocol ViewStateProviding: AnyObject {
    
    
    /// Current viewState
    var viewState: ViewState{ get }
    
    /// Callback to observe view state changes.
    var onViewStateChange: ((ViewState) -> Void)?   { get }
    
}
