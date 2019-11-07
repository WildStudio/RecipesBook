//
//  UICollectionView+Registering.swift
//  RecipePuppy
//
//  Created by wearemobilefirst on 06/11/2019.
//  Copyright © 2019 badi. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func registerRecipeCell(_ reuseIdentifier: String) {
        let nib = RecipeCell.nib()
        register(nib, forCellWithReuseIdentifier: reuseIdentifier)
    }

}
