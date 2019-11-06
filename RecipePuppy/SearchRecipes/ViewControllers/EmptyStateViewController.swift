//
//  EmptyStatesViewController.swift
//  RandomUser
//
//  Created by wearemobilefirst on 31/10/2019.
//  Copyright © 2019 badi. All rights reserved.
//

import UIKit

final class EmptyStateViewController: UIViewController {
    
    private enum Constant {
        static let searchTitle = "Welcome to the Recipe Puppy App"
        static let searchDescription = "What are you waiting for? Start typing to search recipes with ingredients."
        static let favoritesTitle = "Add Favorites"
        static let favoritesDescription = "Add your favorite recipes here!"
    }
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var subtitleLabel: UILabel!
    
    private(set) var titleText: String? {
        didSet { titleLabel.text = configuration.title }
    }
    
    private(set) var subTitleText: String? {
        didSet { subtitleLabel.text = configuration.subtitle }
    }
    
    private let configuration: EmptyStateViewController.Configuration
    
    
    // MARK: - Life cycle
    
    init(configuration: EmptyStateViewController.Configuration) {
        self.configuration = configuration
        super.init(nibName: nil, bundle: nil)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension EmptyStateViewController {
    
    struct Configuration {
        
        let title: String?
        let subtitle: String?
        
        init(
            title: String?,
            subtitle: String? = nil
        ) {
            self.title = title
            self.subtitle = subtitle
        }
    }
}


extension EmptyStateViewController {
    
    // TODO: - Ideally this should be localised and not harcoded
    
    static let searchEmptyState: () -> EmptyStateViewController = {
        return EmptyStateViewController(
            configuration: EmptyStateViewController.Configuration(
                title: Constant.searchTitle,
                subtitle: Constant.searchDescription
            )
        )
    }
  
    static let favoritesEmptyState: () -> EmptyStateViewController = {
        return EmptyStateViewController(
            configuration: EmptyStateViewController.Configuration(
                title: Constant.favoritesTitle,
                subtitle: Constant.favoritesDescription
            )
        )
    }
}

