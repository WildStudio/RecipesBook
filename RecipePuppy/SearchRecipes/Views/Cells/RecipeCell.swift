//
//  RecipeCell.swift
//  RecipesBook
//
//  Created by wearemobilefirst on 01/11/2019.
//  Copyright © 2019 badi. All rights reserved.
//

import UIKit

final class RecipeCell: UICollectionViewCell {
    
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var subtTitleLabel: UILabel!
    
    func configure(with viewModel: RecipeCellViewModel) {
        titleLabel.text = viewModel.title
        subtTitleLabel.text = viewModel.ingredients
    }
}
