//
//  EmptyStatesViewController.swift
//  RandomUser
//
//  Created by wearemobilefirst on 31/10/2019.
//  Copyright © 2019 badi. All rights reserved.
//

import UIKit

final class EmptyStateViewController: UIViewController {

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var subtitleLabel: UILabel!
    
    private(set) var titleText: String? {
        didSet { titleLabel.text = titleText }
    }
    
    private(set) var subTitleText: String? {
        didSet { subtitleLabel.text = subTitleText }
    }
    
    
    func setupView(with title: String, subtitle: String) {
        titleText = title
        subTitleText = subtitle
    }
    
}
