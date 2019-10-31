//
//  ServerConfigType.swift
//  RecipePuppyKit
//
//  Created by wearemobilefirst on 31/10/2019.
//  Copyright © 2019 badi. All rights reserved.
//

import Foundation

/// A type that knows the location of the Recipe Puppy API

public protocol ServerConfigType {
  var apiBaseUrl: URL { get }
}

public struct ServerConfig: ServerConfigType {
    
    public var apiBaseUrl: URL
    
    public init(apiBaseUrl: URL) {
       self.apiBaseUrl = apiBaseUrl
    }

}

