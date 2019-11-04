//
//  Service.swift
//  RecipePuppyKit
//
//  Created by wearemobilefirst on 31/10/2019.
//  Copyright © 2019 badi. All rights reserved.
//

import Foundation
import Models
import os

public struct Service: ServiceType {
    
    private enum Keys {
        static let results = "results"
    }
    
    public let serverConfig: ServerConfigType
    
    
    public init(serverConfig: ServerConfigType) {
        self.serverConfig = serverConfig
    }
    
    
    public func fetchRecipes(
        ingredients: String,
        page: Int? = nil,
        completion: @escaping (Result<[Recipe], Error>) -> Void
    ) {
        request(.recipes(ingredients: ingredients, page: page)) { result in
            switch result {
            case .success(let data):
                guard let users = JSON.decodeModels(Keys.results, data) as [Recipe]?
                    else { return }
                DispatchQueue.main.async {
                    completion(.success(users))
                }
            case .failure(let error):
                DispatchQueue.main.async { completion(.failure(error)) }
            }
        }
    }
    
}

extension Service {
    
    private static let session = URLSession(configuration: .default)
    
    
    private func request(
        _ route: Route,
        completion: @escaping (Result<Data, Error>) -> Void
    ) {
        let properties = route.requestProperties
        
        guard let URL = URL(
            string: properties.path, relativeTo: serverConfig.apiBaseUrl) else {
                fatalError(
                    "URL(string: \(properties.path), relativeToURL: \(String(describing: serverConfig.apiBaseUrl))) == nil"
                )
        }
        
        let request = preparedRequest(
            forURL: URL,
            method: properties.method,
            query: properties.query
        )
        
        Service.session.dataResponse(request, completion: completion)
    }
    
}

