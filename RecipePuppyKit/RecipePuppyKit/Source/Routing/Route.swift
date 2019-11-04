//
//  Route.swift
//  RecipePuppyKit
//
//  Created by wearemobilefirst on 31/10/2019.
//  Copyright © 2019 badi. All rights reserved.
//

import Foundation

enum Route {
    
    case recipes(ingredients: String, page: Int?)
    
    var requestProperties:
        (method: HTTPMethod, path: String, query: [String: Any]) {
        switch self {
        case let .recipes(ingredients, page):
            var params: [String: Any] = [:]
            params["i"] = ingredients
            params["p"] = page
            return (.GET, "/api", params)
        }
    }
    
}
