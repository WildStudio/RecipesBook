//
//  RecipeCell.swift
//  RecipesBook
//
//  Created by wearemobilefirst on 01/11/2019.
//  Copyright © 2019 badi. All rights reserved.
//

import UIKit
import SDWebImage

final class RecipeCell: UICollectionViewCell, NibLoadable {
    
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var tagLabel: EdgeInsetLabel!
    @IBOutlet private var favoriteButton: UIButton!
    
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    private var viewModel: RecipeCellViewModel?
    
    func configure(with viewModel: RecipeCellViewModel?) {
        self.viewModel = viewModel
        
        titleLabel.text = viewModel?.title
        descriptionLabel.text = viewModel?.ingredients
        tagLabel.text = viewModel?.tag
        tagLabel.isHidden = viewModel?.shouldHideTagLabel ?? true
        favoriteButton.isSelected = viewModel?.isFavourite ?? false
        
        if let imageURL = viewModel?.imageURL {
            imageView?.sd_setImage(with: imageURL)
        }
    }
    
    
    @IBAction private func didTapFavoriteButton(_ sender: UIButton) {
        guard let viewModel = viewModel else { return }
        viewModel.favorite()
        sender.isSelected = !sender.isSelected
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.leftAnchor.constraint(equalTo: leftAnchor),
            contentView.rightAnchor.constraint(equalTo: rightAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
