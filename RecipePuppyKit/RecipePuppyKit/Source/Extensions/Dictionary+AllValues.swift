//
//  Dictionary+AllValues.swift
//  RecipePuppyKit
//
//  Created by wearemobilefirst on 31/10/2019.
//  Copyright © 2019 badi. All rights reserved.
//

import Foundation

extension Dictionary {
    
    func withAllValuesFrom(_ other: Dictionary) -> Dictionary {
        return self.merging(other) { $1 }
    }
}
