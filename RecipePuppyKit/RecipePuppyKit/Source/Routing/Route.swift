//
//  Route.swift
//  RecipePuppyKit
//
//  Created by wearemobilefirst on 31/10/2019.
//  Copyright © 2019 badi. All rights reserved.
//

import Foundation

enum Route {
    
    case recipes(ingredients: String)
    
    var requestProperties:
        (method: HTTPMethod, path: String, query: [String: Any]) {
        switch self {
        case let .recipes(ingredients):
            var params: [String: Any] = [:]
            params["i"] = ingredients
            return (.GET, "/api", params)
        }
    }
    
}
