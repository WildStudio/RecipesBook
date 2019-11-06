//
//  RecipesStore.swift
//  RecipePuppy
//
//  Created by wearemobilefirst on 06/11/2019.
//  Copyright © 2019 badi. All rights reserved.
//

import Foundation
import Models

protocol FavoriteListener: class {
    func didUpdateFavorites()
}

final class RecipesStore: StoreServiceType {
    
    typealias Model = Recipe
    
    var listeners: [ListenerWrapper] = []
    
    private let _key = "com.badi.RecipePuppy.favorites"
    
    var key: String {
        return _key
    }
    
    var values: [Recipe]
    
    let defaults = UserDefaults.standard
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
    
    init() {
        guard let data = defaults.object(forKey: _key) as? Data,
            let array = try? decoder.decode([Recipe].self, from: data)
            else {
                self.values = []
                return
        }
        
        self.values = array
    }
    
}
