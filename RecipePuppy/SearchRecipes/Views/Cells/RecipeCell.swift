//
//  RecipeCell.swift
//  RecipesBook
//
//  Created by wearemobilefirst on 01/11/2019.
//  Copyright © 2019 badi. All rights reserved.
//

import UIKit
import SDWebImage

final class RecipeCell: UICollectionViewCell {
    
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var tagLabel: EdgeInsetLabel!
    @IBOutlet private var favoriteButton: UIButton!
    
    private var viewModel: RecipeCellViewModel?
    
    func configure(with viewModel: RecipeCellViewModel) {
        self.viewModel = viewModel
        
        titleLabel.text = viewModel.title
        descriptionLabel.text = viewModel.ingredients
        tagLabel.text = viewModel.tag
        tagLabel.isHidden = viewModel.shouldHideTagLabel
        favoriteButton.isSelected = viewModel.isFavourite
        
        if let imageURL = viewModel.imageURL {
            imageView?.sd_setImage(with: imageURL)
        }
    }
    
    
    @IBAction private func didTapFavoriteButton(_ sender: UIButton) {
        guard let viewModel = viewModel else { return }
        viewModel.favorite()
        
        if sender.isSelected == true {
            sender.isSelected = false
        } else {
            sender.isSelected = true
        }
    }
    
}
